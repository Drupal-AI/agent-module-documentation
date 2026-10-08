#!/usr/bin/env node
// Aggregates ../../modules/**/<version>/data.json (+ eval/) into public/data/*.json.
// No dependencies — plain Node fs.
import { readdirSync, readFileSync, existsSync, mkdirSync, writeFileSync, statSync } from 'node:fs';
import { dirname, join, relative, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const MODULES = resolve(__dirname, '../../modules');
const OUT = resolve(__dirname, '../public/data');

function readJSON(p) {
  try { return JSON.parse(readFileSync(p, 'utf8')); }
  catch (e) { console.warn(`  ! skipping unparseable ${relative(MODULES, p)}: ${e.message}`); return null; }
}

// Recursively find every data.json under MODULES.
function findDataFiles(dir, acc = []) {
  for (const name of readdirSync(dir)) {
    const full = join(dir, name);
    if (statSync(full).isDirectory()) findDataFiles(full, acc);
    else if (name === 'data.json') acc.push(full);
  }
  return acc;
}

const catalog = [];
const evalResults = {};
let withEvals = 0, withResults = 0;

for (const dataPath of findDataFiles(MODULES)) {
  const d = readJSON(dataPath);
  if (!d) continue;
  const versionDir = dirname(dataPath);
  const docPath = relative(MODULES, versionDir);          // e.g. ai/modules/ai_search/1.4.x
  const evalsPath = join(versionDir, 'eval', 'evals.json');
  const resultsPath = join(versionDir, 'eval', 'results.json');
  const hasEvals = existsSync(evalsPath);
  const hasResults = existsSync(resultsPath);
  const key = d.data_name || docPath.split('/')[0];

  let evalCount = 0;
  if (hasEvals) {
    const ev = readJSON(evalsPath);
    evalCount = ev?.evals?.length ?? 0;
    withEvals++;
  }
  if (hasResults) {
    const res = readJSON(resultsPath);
    if (res) { evalResults[key] = res; withResults++; }
  }

  catalog.push({
    key,
    name: d.name ?? key,
    description: d.description ?? '',
    version: d.version ?? docPath.split('/').pop(),
    docPath,
    list_position: d.list_position ?? null,
    active_installs: d.active_installs ?? null,
    part_of: d.part_of ?? null,
    categories: d.categories ?? [],
    subcategories: d.subcategories ?? [],
    keywords: d.keywords ?? [],
    project_url: d.project_url ?? null,
    provides: {
      permissions: !!d.provides_permissions,
      drush_commands: !!d.provides_drush_commands,
      config_schema: !!d.provides_config_schema,
      plugin_types: d.provides_plugin_types ?? [],
      config_entities: d.provides_config_entities ?? [],
      content_entities: d.provides_content_entities ?? [],
    },
    hasEvals,
    hasResults,
    evalCount,
  });
}

// Sort by popularity rank (nulls last), then name.
catalog.sort((a, b) => {
  const ax = a.list_position ?? Infinity, bx = b.list_position ?? Infinity;
  return ax - bx || a.name.localeCompare(b.name);
});

mkdirSync(OUT, { recursive: true });
const generated_at = process.env.SOURCE_DATE_EPOCH
  ? new Date(Number(process.env.SOURCE_DATE_EPOCH) * 1000).toISOString()
  : null;
writeFileSync(join(OUT, 'catalog.json'),
  JSON.stringify({ generated_at, count: catalog.length, modules: catalog }, null, 2));
writeFileSync(join(OUT, 'eval-results.json'),
  JSON.stringify(evalResults, null, 2));

console.log(`build-data: ${catalog.length} modules, ${withEvals} with evals, ${withResults} with results`);
console.log(`  -> ${relative(process.cwd(), join(OUT, 'catalog.json'))}`);
console.log(`  -> ${relative(process.cwd(), join(OUT, 'eval-results.json'))}`);
