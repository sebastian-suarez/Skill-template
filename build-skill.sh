#!/usr/bin/env bash
set -euo pipefail

#
# build-skill.sh
#
# Assembles the final Skill folder from transpiled JS + static files.
# Run via: npm run build:skill (lint + test + build + assemble)
#      or: npm run build:skill:fast (build + assemble, skip checks)
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Repo root if this script lives at project root; parent if it lives in scripts/
if [[ "$(basename "$SCRIPT_DIR")" == "scripts" ]]; then
	PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
else
	PROJECT_ROOT="$SCRIPT_DIR"
fi

# Read skill name from skill/SKILL.md frontmatter (fallback to package.json name)
SKILL_NAME=$(grep -m1 '^name:' "$PROJECT_ROOT/skill/SKILL.md" 2>/dev/null | sed 's/name:[[:space:]]*//' || true)
if [ -z "$SKILL_NAME" ]; then
  SKILL_NAME=$(node -e "console.log(require('./package.json').name)" 2>/dev/null || echo "my-skill")
fi

DIST_DIR="$PROJECT_ROOT/dist"
SKILL_DIR="$DIST_DIR/$SKILL_NAME"

echo ""
echo "🔧 Assembling skill: $SKILL_NAME"
echo "   Output: $SKILL_DIR"
echo ""

# ── 1. Clean previous skill assembly (keep tsup output) ──
rm -rf "$SKILL_DIR"
mkdir -p "$SKILL_DIR/scripts"

# ── 2. Copy transpiled JS into scripts/ ──
# tsup outputs to dist/*.mjs (or *.js depending on format).
# We copy all JS/MJS files, preserving any nested structure.
find "$DIST_DIR" -maxdepth 1 \( -name "*.js" -o -name "*.mjs" \) -exec cp {} "$SKILL_DIR/scripts/" \;
echo "   ✓ Copied transpiled scripts"

# ── 3. Copy SKILL.md ──
if [ -f "$PROJECT_ROOT/skill/SKILL.md" ]; then
  cp "$PROJECT_ROOT/skill/SKILL.md" "$SKILL_DIR/SKILL.md"
  echo "   ✓ Copied SKILL.md"
else
  echo "   ⚠ No skill/SKILL.md found — you'll need to create one"
fi

# ── 4. Copy assets/ (static files the skill needs at runtime) ──
if [ -d "$PROJECT_ROOT/skill/assets" ] && [ "$(ls -A "$PROJECT_ROOT/skill/assets" 2>/dev/null)" ]; then
  cp -r "$PROJECT_ROOT/skill/assets" "$SKILL_DIR/assets"
  echo "   ✓ Copied assets/"
fi

# ── 5. Copy references/ (documentation loaded on demand) ──
if [ -d "$PROJECT_ROOT/skill/references" ] && [ "$(ls -A "$PROJECT_ROOT/skill/references" 2>/dev/null)" ]; then
  cp -r "$PROJECT_ROOT/skill/references" "$SKILL_DIR/references"
  echo "   ✓ Copied references/"
fi

# ── 6. Make all scripts executable ──
find "$SKILL_DIR/scripts" -name "*.js" -o -name "*.mjs" | xargs chmod +x 2>/dev/null || true

# ── 7. Summary ──
echo ""
echo "✅ Skill assembled:"
find "$SKILL_DIR" -type f | sort | sed "s|$DIST_DIR/||" | while read -r f; do
  echo "   $f"
done

# ── 8. Package as .skill file ──
SKILL_FILE="$DIST_DIR/$SKILL_NAME.skill"
tar -czf "$SKILL_FILE" -C "$DIST_DIR" "$SKILL_NAME"
echo ""
echo "📦 Packaged: $SKILL_FILE"
echo ""