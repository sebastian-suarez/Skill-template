/* eslint-disable unicorn/no-process-exit */
import process from "node:process";

const input = process.argv.slice(2).join(" ");

if (!input) {
	console.log(JSON.stringify({ error: "No text provided" }));
	process.exit(1);
}

const words = input.trim().split(/\s+/).length;
const chars = input.length;
const sentences = input.split(/[.!?]+/).filter(Boolean).length;

console.log(JSON.stringify({ words, chars, sentences }));
