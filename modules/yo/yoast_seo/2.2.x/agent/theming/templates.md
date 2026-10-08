# Theme hooks & templates

Registered in `yoast_seo_theme()` (templates in `templates/`):

| Theme hook | Template | Variables |
|---|---|---|
| `yoast_snippet` | `yoast-snippet.html.twig` | `wrapper_target_id`, `snippet_target_id`, `output_target_id` — DOM targets rtseo.js writes the Google snippet preview into |
| `overall_score` | `overall_score.html.twig` | `overall_score_target_id`, `overall_score` — the live SEO score badge on the edit form |
| `view_overall_score` | `view_overall_score.html.twig` | `overall_score` — score badge for Views output |
| `content_score` | `content_score.html.twig` | (none) — container the analysis list renders into |

Override any of these by copying the template into your theme. CSS/JS assets are attached via
the libraries in `yoast_seo.libraries.yml` (`yoast_seo_core` loads `js/yoast_seo.js` + the
remote `analytics_core` rtseo.js library).
