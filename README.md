# ✨ Skill Template

Hey there! This repo is a cozy **TypeScript starter** for building **Agent Skills**—the kind with real scripts you can run, not just prose. You write TypeScript, **tsup** bundles everything into plain ESM (no `node_modules` needed at runtime), and a small assemble step turns that into a folder (plus a **`.skill`** tarball) you can share or install.

If you want tests, lint, and format on day one, you get those too. Think of it as: code → bundle → skill package, with guardrails.

## 🎯 What you get

- **TypeScript + Node ESM** with `#src/*` and `#modules/*` import aliases
- **tsup** bundles each entry into standalone `.mjs` files for the skill’s `scripts/` folder
- **Jest** + **ts-jest** for unit tests (ESM-friendly setup)
- **XO** + **Prettier** so style stays consistent without a debate
- **build-skill.sh** copies `SKILL.md`, optional `assets/` and `references/`, and packs **`dist/<skill-name>.skill`**
- **`evals/evals.json`** as a starting point for prompt/eval scenarios (tweak to match _your_ skill)

## 📦 Requirements

- **Node.js 18+**

## 🚀 Quick start

```bash
npm install
npm test
npm start
```

## 🛠️ Scripts

| Command                    | What it does                                            |
| -------------------------- | ------------------------------------------------------- |
| `npm start`                | Run `src/index.ts` with `tsx`                           |
| `npm test`                 | Run Jest                                                |
| `npm run lint`             | Lint (and fix) with XO                                  |
| `npm run format`           | Format with Prettier                                    |
| `npm run build`            | Bundle with tsup into `dist/`                           |
| `npm run build:skill`      | Lint + test + build + assemble skill + `.skill` package |
| `npm run build:skill:fast` | Build + assemble only (handy when you’re iterating)     |
| `npm run clean`            | Remove `dist/`                                          |

## 📁 Where things live

| Path                | Purpose                                                                 |
| ------------------- | ----------------------------------------------------------------------- |
| `src/`              | TypeScript source; add more **tsup** entry files as your skill grows    |
| `skill/SKILL.md`    | Skill definition + frontmatter (`name:` is used for the output folder)  |
| `skill/assets/`     | Optional static files copied into the skill                             |
| `skill/references/` | Optional docs loaded on demand                                          |
| `dist/`             | Bundled JS + assembled skill folder + `.skill` archive after build      |
| `evals/evals.json`  | Starter eval definitions—rename `skill_name` and prompts to match yours |

> **Heads-up:** The assemble script looks for **`skill/SKILL.md`**. If you’ve been editing `SKILL.md` at the repo root, create a `skill/` directory and move/copy it there so packaging picks it up.

## 🧩 Customizing the bundle

Open `tsup.config.ts`: **`entry`** controls which files become runnable scripts under `scripts/` in the final skill. Dependencies are **inlined** so the skill runs without installing packages in the agent environment.

## 💬 Repo & issues

- **Homepage:** [github.com/sebastian-suarez/Skill-template](https://github.com/sebastian-suarez/Skill-template#readme)
- **Issues:** [github.com/sebastian-suarez/Skill-template/issues](https://github.com/sebastian-suarez/Skill-template/issues)

Happy building—and may your skills always bundle on the first try. 🎉
