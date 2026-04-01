import { execSync } from "node:child_process";

test("counts words correctly", () => {
	const result = execSync('tsx src/index.ts "hello world foo"').toString();
	const parsed = JSON.parse(result) as { words: number };
	expect(parsed.words).toBe(3);
});
