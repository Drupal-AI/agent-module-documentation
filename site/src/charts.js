import Chart from 'chart.js/auto';

// Stable, colour-blind-friendly-ish palette; series get a colour by index.
const PALETTE = [
  '#2f6feb', '#1f9d55', '#e0803a', '#7b3fe4', '#d64545',
  '#0e9aa7', '#c8a415', '#d6459b', '#5b6472', '#3aa0e0',
];
export const seriesColor = (i) => PALETTE[i % PALETTE.length];

function themeColors() {
  const dark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
  return {
    grid: dark ? 'rgba(255,255,255,.08)' : 'rgba(16,24,40,.08)',
    text: dark ? '#98a2b3' : '#5b6472',
  };
}

// datasets: [{label, data:[...], color}], labels: short x labels (Q1..Qn),
// questions: {label: text} for the tooltip title, onActiveIndex(idx|null) fires on hover.
export function groupedBar(canvas, { labels, datasets, yLabel, questions, valueFmt, onActiveIndex }) {
  const t = themeColors();
  return new Chart(canvas, {
    type: 'bar',
    data: {
      labels,
      datasets: datasets.map((d) => ({
        label: d.label,
        data: d.data,
        backgroundColor: d.color,
        borderColor: d.color,
        borderWidth: 1,
        borderRadius: 3,
        maxBarThickness: 34,
      })),
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      interaction: { mode: 'index', intersect: false },
      onHover: (_evt, elements) => {
        if (onActiveIndex) onActiveIndex(elements.length ? elements[0].index : null);
      },
      plugins: {
        legend: { labels: { color: t.text, boxWidth: 12, font: { size: 11 } } },
        tooltip: {
          callbacks: {
            title: (items) => questions[items[0].label] || items[0].label,
            label: (item) => {
              const v = item.raw;
              if (v == null) return `${item.dataset.label}: —`;
              return `${item.dataset.label}: ${valueFmt ? valueFmt(v) : v}`;
            },
          },
        },
      },
      scales: {
        x: { ticks: { color: t.text, font: { size: 10 } }, grid: { display: false } },
        y: {
          beginAtZero: true,
          title: { display: !!yLabel, text: yLabel, color: t.text, font: { size: 11 } },
          ticks: { color: t.text, font: { size: 10 } },
          grid: { color: t.grid },
        },
      },
    },
  });
}
