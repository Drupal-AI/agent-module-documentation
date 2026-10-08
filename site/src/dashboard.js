import './style.css';
import { groupedBar, seriesColor } from './charts.js';

const $ = (id) => document.getElementById(id);
const esc = (s) => String(s).replace(/[&<>"]/g, (c) => (
  { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));

// Metrics to graph. `get` pulls the value from a results leaf (null = gap).
// A fully-failed run (no passing runs) is shown as 0 cost / 0 time, so a failure never
// looks like a cheap, fast success — only successful work counts toward those bars.
const failed = (l) => l.runs && l.correct === 0;
const METRICS = [
  { key: 'failrate', title: 'Failure rate', yLabel: '%', get: (l) => l.runs ? (1 - l.correct / l.runs) * 100 : null, fmt: (v) => `${v.toFixed(0)}%` },
  { key: 'time', title: 'Time', yLabel: 'seconds', get: (l) => failed(l) ? 0 : l.time, fmt: (v) => `${v}s` },
  { key: 'cost', title: 'Cost', yLabel: 'USD', get: (l) => failed(l) ? 0 : l.cost, fmt: (v) => `$${v.toFixed(4)}` },
];

// Display label: mention the coding agent (Claude Code) that ran the eval,
// e.g. "claude-haiku-4-5-20251001:medium" -> "claude-code:haiku-4-5-20251001:medium".
const shortModel = (m) => `claude-code:${m.replace(/^claude-/, '')}`;
const ARM_ORDER = { vanilla: 0, skill: 1, memory: 2 };
const armColor = (arm) => seriesColor(ARM_ORDER[arm] ?? 8);

let charts = [];
let DATA = {};

// Distinct model:effort run keys present in a module's cases.
function modelsFor(cases) {
  const set = new Set();
  for (const c of Object.values(cases))
    for (const runs of Object.values(c.results || {}))
      for (const rk of Object.keys(runs)) set.add(rk);
  return [...set].sort();
}

// Distinct arms that have data for a given model, in canonical order.
function armsForModel(cases, model) {
  const set = new Set();
  for (const c of Object.values(cases))
    for (const [arm, runs] of Object.entries(c.results || {}))
      if (runs[model]) set.add(arm);
  return [...set].sort((a, b) => (ARM_ORDER[a] ?? 9) - (ARM_ORDER[b] ?? 9));
}

function renderCharts(moduleKey, model) {
  charts.forEach((c) => c.destroy());
  charts = [];
  const container = $('charts');
  container.innerHTML = '';
  const mod = DATA[moduleKey];
  if (!mod) return;

  const cases = mod.cases;
  const caseIds = Object.keys(cases);
  // Short x-axis labels (Q1..Qn) so nothing gets truncated; the full question text
  // is shown in the numbered list below the charts and in each bar's tooltip.
  const xlabels = caseIds.map((_, i) => `Q${i + 1}`);
  const questions = Object.fromEntries(xlabels.map((lbl, i) => [lbl, cases[caseIds[i]].question || caseIds[i]]));
  const arms = armsForModel(cases, model);

  $('meta').textContent = `${caseIds.length} questions · ${arms.length} arms · ${shortModel(model)} · skill: ${mod.skill_name}`;
  $('legendNote').innerHTML = `Model <strong>${esc(shortModel(model))}</strong>. Series = <strong>arm</strong>: `
    + arms.map((a) => `<span style="color:${armColor(a)}">■</span> ${esc(a)}`).join(' &nbsp; ');

  // Highlight the hovered question across the list below the charts.
  const setActive = (idx) => {
    document.querySelectorAll('#qlist li').forEach((li, i) => li.classList.toggle('active', i === idx));
  };

  for (const metric of METRICS) {
    const datasets = arms.map((arm) => ({
      label: arm,
      color: armColor(arm),
      data: caseIds.map((id) => {
        const leaf = cases[id].results?.[arm]?.[model];
        return leaf ? metric.get(leaf) : null;
      }),
    }));
    // Skip a metric if every value is null (e.g. cache_reads on older runs).
    if (datasets.every((d) => d.data.every((v) => v == null))) continue;

    const card = document.createElement('div');
    card.className = 'chart-card';
    card.innerHTML = `<h3>${esc(metric.title)}</h3>
      <div class="sub">per question · lower is better</div>
      <div class="chart-wrap"><canvas></canvas></div>`;
    container.appendChild(card);
    charts.push(groupedBar(card.querySelector('canvas'), {
      labels: xlabels,
      datasets,
      yLabel: metric.yLabel,
      questions,
      valueFmt: metric.fmt,
      onActiveIndex: setActive,
    }));
  }

  // Numbered question list under the charts (Q1..Qn), with difficulty + persona tags.
  $('qlist').innerHTML = caseIds.map((id, i) => {
    const c = cases[id];
    const tier = c.difficulty ? `<span class="qtier ${esc(c.difficulty)}">${esc(c.difficulty)}</span>` : '';
    const persona = c.persona ? `<span class="qpersona">${esc(c.persona)}</span>` : '';
    return `<li data-idx="${i}"><span class="qnum">Q${i + 1}</span>${tier}${persona}`
      + `<span class="qtext">${esc(c.question || id)}</span>`
      + `<span class="qid">${esc(id)}</span></li>`;
  }).join('');
}

// Populate the model dropdown for a module; keep the current pick if still available.
function populateModels(moduleKey, preferred) {
  const models = modelsFor(DATA[moduleKey].cases);
  const sel = $('model');
  sel.innerHTML = models.map((m) => `<option value="${esc(m)}">${esc(shortModel(m))}</option>`).join('');
  const pick = preferred && models.includes(preferred) ? preferred : models[0];
  sel.value = pick;
  return pick;
}

function updateUrl(moduleKey, model) {
  history.replaceState(null, '', `?module=${encodeURIComponent(moduleKey)}&model=${encodeURIComponent(model)}`);
}

async function main() {
  const res = await fetch('./data/eval-results.json');
  DATA = await res.json();
  const keys = Object.keys(DATA).sort();
  $('stat').textContent = `${keys.length} modules with results`;

  if (!keys.length) { $('empty').hidden = false; return; }

  const moduleSel = $('module');
  moduleSel.innerHTML = keys.map((k) => {
    const v = DATA[k].version ? ` (${DATA[k].version})` : '';
    return `<option value="${esc(k)}">${esc(k)}${esc(v)}</option>`;
  }).join('');

  const params = new URLSearchParams(location.search);
  const wantedModule = params.get('module');
  const wantedModel = params.get('model');
  const startModule = wantedModule && DATA[wantedModule] ? wantedModule : keys[0];
  moduleSel.value = startModule;
  let model = populateModels(startModule, wantedModel);

  const draw = () => { renderCharts(moduleSel.value, $('model').value); updateUrl(moduleSel.value, $('model').value); };

  moduleSel.addEventListener('change', () => {
    model = populateModels(moduleSel.value, $('model').value); // keep model if the new module has it
    draw();
  });
  $('model').addEventListener('change', draw);

  renderCharts(startModule, model);
  updateUrl(startModule, model);
}

main().catch((e) => { $('charts').innerHTML = `<div class="empty">Failed to load results: ${esc(e.message)}</div>`; });
