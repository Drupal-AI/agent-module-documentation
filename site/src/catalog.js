import './style.css';

const $ = (id) => document.getElementById(id);
const PAGE_SIZE = 48;
const state = { all: [], q: '', category: '', tier: 0, evalsOnly: false, resultsOnly: false, page: 1 };

// Source links point at the GitHub repo the site is built from.
const REPO_BLOB = 'https://github.com/Drupal-AI/agent-module-documentation/blob/main/modules';

const esc = (s) => String(s).replace(/[&<>"]/g, (c) => (
  { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));

function matches(m) {
  if (state.evalsOnly && !m.hasEvals) return false;
  if (state.resultsOnly && !m.hasResults) return false;
  if (state.category && !m.categories.includes(state.category)) return false;
  if (state.tier && !(m.list_position && m.list_position <= state.tier)) return false;
  if (state.q && !state.q.split(/\s+/).every((t) => m.hay.includes(t))) return false;
  return true;
}

function providesChips(p) {
  const chips = [];
  if (p.plugin_types) chips.push(`${p.plugin_types} plugin type${p.plugin_types > 1 ? 's' : ''}`);
  if (p.config_entities) chips.push('config entities');
  if (p.content_entities) chips.push('content entities');
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

// Page numbers to show: first, last, and a window around the current page.
function pageList(page, pages) {
  const out = [];
  for (let p = 1; p <= pages; p++) {
    if (p === 1 || p === pages || Math.abs(p - page) <= 2) out.push(p);
    else if (out[out.length - 1] !== '…') out.push('…');
  }
  return out;
}

function pagerHTML(page, pages) {
  if (pages <= 1) return '';
  const btn = (p, label, extra = '') =>
    `<button type="button" data-page="${p}" ${extra}>${label}</button>`;
  return [
    btn(page - 1, '‹ Prev', page === 1 ? 'disabled' : ''),
    ...pageList(page, pages).map((p) => (p === '…'
      ? '<span class="gap">…</span>'
      : btn(p, p, p === page ? 'aria-current="page" class="current"' : ''))),
    btn(page + 1, 'Next ›', page === pages ? 'disabled' : ''),
  ].join('');
}

function syncURL() {
  const u = new URLSearchParams();
  if (state.q) u.set('q', state.q);
  if (state.category) u.set('category', state.category);
  if (state.tier) u.set('tier', state.tier);
  if (state.evalsOnly) u.set('evals', '1');
  if (state.resultsOnly) u.set('results', '1');
  if (state.page > 1) u.set('page', state.page);
  const qs = u.toString();
  history.replaceState(null, '', qs ? `?${qs}` : location.pathname);
}

function render() {
  const filtered = state.all.filter(matches);
  const pages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
  state.page = Math.min(Math.max(1, state.page), pages);
  const start = (state.page - 1) * PAGE_SIZE;
  $('grid').innerHTML = filtered.slice(start, start + PAGE_SIZE).map(cardHTML).join('');
  $('count').textContent = filtered.length
    ? `${start + 1}–${Math.min(start + PAGE_SIZE, filtered.length)} of ${filtered.length}` +
      (filtered.length !== state.all.length ? ` (${state.all.length} total)` : '')
    : `0 of ${state.all.length}`;
  $('empty').hidden = filtered.length !== 0;
  const pager = pagerHTML(state.page, pages);
  $('pagerTop').innerHTML = pager;
  $('pagerBottom').innerHTML = pager;
  syncURL();
}

// Any filter change starts again at page 1.
function setFilter(key, value) { state[key] = value; state.page = 1; render(); }

function initControls() {
  let t;
  $('q').addEventListener('input', (e) => {
    clearTimeout(t);
    t = setTimeout(() => setFilter('q', e.target.value.trim().toLowerCase()), 150);
  });
  $('category').addEventListener('change', (e) => setFilter('category', e.target.value));
  $('tier').addEventListener('change', (e) => setFilter('tier', Number(e.target.value)));
  $('evalsOnly').addEventListener('change', (e) => setFilter('evalsOnly', e.target.checked));
  $('resultsOnly').addEventListener('change', (e) => setFilter('resultsOnly', e.target.checked));
  for (const id of ['pagerTop', 'pagerBottom']) {
    $(id).addEventListener('click', (e) => {
      const b = e.target.closest('button[data-page]');
      if (!b || b.disabled) return;
      state.page = Number(b.dataset.page);
      render();
      if (id === 'pagerBottom') $('pagerTop').scrollIntoView({ block: 'start' });
    });
  }
}

// Restore filters and page from the URL (so links and reloads keep their place).
function readURL() {
  const u = new URLSearchParams(location.search);
  state.q = (u.get('q') || '').toLowerCase();
  state.category = u.get('category') || '';
  state.tier = Number(u.get('tier')) || 0;
  state.evalsOnly = u.get('evals') === '1';
  state.resultsOnly = u.get('results') === '1';
  state.page = Number(u.get('page')) || 1;
  $('q').value = state.q;
  $('tier').value = String(state.tier);
  $('evalsOnly').checked = state.evalsOnly;
  $('resultsOnly').checked = state.resultsOnly;
}

async function main() {
  const res = await fetch('./data/catalog.json');
  const data = await res.json();
  state.all = data.modules;
  // Pre-build the lowercase search text once instead of on every keystroke.
  for (const m of state.all) {
    m.hay = (m.name + ' ' + m.key + ' ' + m.description + ' ' + m.keywords.join(' ')).toLowerCase();
  }
  const cats = [...new Set(state.all.flatMap((m) => m.categories))].sort();
  $('category').insertAdjacentHTML('beforeend',
    cats.map((c) => `<option value="${esc(c)}">${esc(c)}</option>`).join(''));
  const withEvals = state.all.filter((m) => m.hasEvals).length;
  const withResults = state.all.filter((m) => m.hasResults).length;
  $('stat').textContent = `${data.count} modules · ${withEvals} with evals · ${withResults} with results`;
  readURL();
  $('category').value = state.category;
  initControls();
  render();
}

main().catch((e) => { $('grid').innerHTML = `<div class="empty">Failed to load catalog: ${esc(e.message)}</div>`; });
