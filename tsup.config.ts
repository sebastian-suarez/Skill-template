import { defineConfig } from "tsup";

export default defineConfig({
	// Entry points — each becomes an independently runnable script in the skill.
	// Add more entries as your skill grows (e.g., "src/analyze.ts", "src/transform.ts").
	entry: ["src/index.ts"],

	// Output ESM since the project uses "type": "module"
	format: ["esm"],

	// Bundle all dependencies inline so the skill has zero runtime deps.
	// Claude's environment won't have your node_modules.
	bundle: true,

	// Resolve Node.js subpath imports (#src/*, #modules/*)
	// tsup/esbuild reads the "imports" field in package.json automatically.

	// Target Node 18+ (matches the template's engine requirement)
	target: "node18",

	// Clean dist/ before each build
	clean: true,

	// Generate sourcemaps for easier debugging during development
	sourcemap: true,

	// No need for .d.ts in skill scripts
	dts: false,

	// Keep console output minimal
	silent: false,

	// Mark Node built-ins as external (they exist in Claude's environment)
	platform: "node",

	// Output to dist/ — the build-skill script moves files into the skill folder
	outDir: "dist",
});
