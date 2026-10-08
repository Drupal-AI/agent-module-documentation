# Configure Real-time SEO

Global settings form: `SettingsForm` at `/admin/config/yoast_seo` (route `yoast_seo.settings`,
permission `administer yoast seo`). Stored as simple config `yoast_seo.settings`.

Keys (`config/install/yoast_seo.settings.yml`, schema in `config/schema/yoast_seo.schema.yml`):
```yaml
score_rules:                 # score threshold -> status label
  0: 'Not available'
  1: 'Bad'
  5: 'Okay'
  8: 'Good'
auto_refresh_seo_result: false   # re-run analysis automatically as content changes
```

- `score_rules` maps a numeric score threshold to a human label; `SeoManager::getScoreStatus()`
  looks up the label for a given 0–100 score.
- `auto_refresh_seo_result` toggles live re-analysis vs manual refresh.
- Which bundles get the analysis is determined by where the `yoast_seo` field is present — see
  [field.md](field.md); `SeoManager::getEnabledBundles()` lists them.
