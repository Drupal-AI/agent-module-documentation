import './style.css';

const $ = (id) => document.getElementById(id);
const state = { all: [], q: '', category: '', tier: 0, evalsOnly: false, resultsOnly: false };

// Source links point at the GitHub repo the site is built from.
const REPO_BLOB = 'https://github.com/ivanboring/agent-module-documentation/blob/main/modules';

const esc = (s) => String(s).replace(/[&<>"]/g, (c) => (
  { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));

function matches(m) {
  if (state.evalsOnly && !m.hasEvals) return false;
  if (state.resultsOnly && !m.hasResults) return false;
  if (state.category && !m.categories.includes(state.category)) return false;
  if (state.tier && !(m.list_position && m.list_position <= state.tier)) return false;
  if (state.q) {
    const hay = (m.name + ' ' + m.key + ' ' + m.description + ' ' + m.keywords.join(' ')).toLowerCase();
    if (!state.q.split(/\s+/).every((t) => hay.includes(t))) return false;
  }
  return true;
}

function providesChips(p) {
  const chips = [];
  if (p.plugin_types.length) chips.push(`${p.plugin_types.length} plugin type${p.plugin_types.length > 1 ? 's' : ''}`);
  if (p.config_entities.length) chips.push('config entities');
  if (p.content_entities.length) chips.push('content entities');
  if (p.drush_commands) chips.push('drush');
  if (p.config_schema) chips.push('config');
  if (p.permissions) chips.push('permissions');
  return chips.map((c) => `<span class="tag">${esc(c)}</span>`).join('');
}

function cardHTML(m) {
  const rank = m.list_position ? `#${m.list_position}` : '—';
  const installs = m.active_installs != null ? `${m.active_installs.toLocaleString()} installs` : '';
  const cats = m.categories.slice(0, 2).map((c) => `<span class="tag cat">${esc(c)}</span>`).join('');
  const part = m.part_of ? `<span class="tag">part of ${esc(m.part_of)}</span>` : '';
  // Helper text = the agent-consumable docs; link straight to where they start (start.md).
  const docBase = m.docPath ? `${REPO_BLOB}/${m.docPath}` : null;
  const helperLink = docBase
    ? `<a class="lnk" href="${docBase}/agent/start.md" target="_blank" rel="noopener">helper text ↗</a>` : '';
  const evalsLink = (m.hasEvals && docBase)
    ? `<a class="lnk" href="${docBase}/eval/evals.json" target="_blank" rel="noopener">${m.evalCount} evals ↗</a>` : '';
  const resultsLink = m.hasResults
    ? `<a class="lnk results" href="./dashboard.html?module=${encodeURIComponent(m.key)}">📊 results</a>` : '';
  return `<div class="card">
    <div class="top">
      <span class="name">${esc(m.name)}</span>
      <span class="machine">${esc(m.key)}</span>
      <span class="rank" title="popularity rank by active installs">${rank}</span>
    </div>
    <div class="desc">${esc(m.description)}</div>
    <div class="tags">${cats}${part}${providesChips(m.provides)}</div>
    <div class="links">${helperLink}${evalsLink}${resultsLink}</div>
    <div class="foot">
      ${installs ? `<span class="installs">${installs} · ${esc(m.version)}</span>` : `<span class="installs">${esc(m.version)}</span>`}
    </div>
  </div>`;
}

function render() {
  const filtered = state.all.filter(matches);
  $('grid').innerHTML = filtered.map(cardHTML).join('');
  $('count').textContent = `${filtered.length} of ${state.all.length}`;
  $('empty').hidden = filtered.length !== 0;
}

function initControls() {
  $('q').addEventListener('input', (e) => { state.q = e.target.value.trim().toLowerCase(); render(); });
  $('category').addEventListener('change', (e) => { state.category = e.target.value; render(); });
  $('tier').addEventListener('change', (e) => { state.tier = Number(e.target.value); render(); });
  $('evalsOnly').addEventListener('change', (e) => { state.evalsOnly = e.target.checked; render(); });
  $('resultsOnly').addEventListener('change', (e) => { state.resultsOnly = e.target.checked; render(); });
}

async function main() {
  const res = await fetch('./data/catalog.json');
  const data = await res.json();
  state.all = data.modules;
  const cats = [...new Set(state.all.flatMap((m) => m.categories))].sort();
  $('category').insertAdjacentHTML('beforeend',
    cats.map((c) => `<option value="${esc(c)}">${esc(c)}</option>`).join(''));
  const withEvals = state.all.filter((m) => m.hasEvals).length;
  const withResults = state.all.filter((m) => m.hasResults).length;
  $('stat').textContent = `${data.count} modules · ${withEvals} with evals · ${withResults} with results`;
  initControls();
  render();
}

main().catch((e) => { $('grid').innerHTML = `<div class="empty">Failed to load catalog: ${esc(e.message)}</div>`; });
