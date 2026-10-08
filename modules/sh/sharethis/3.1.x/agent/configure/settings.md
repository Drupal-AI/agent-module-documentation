# ShareThis — configuration

## Settings form

- Route: `sharethis.configuration_form`
- Path: `/admin/config/services/sharethis`
- Permission: `administer sharethis`
- Class: `Drupal\sharethis\Form\SharethisConfigurationForm`

## Config object: `sharethis.settings`

Defaults ship in `config/install/sharethis.settings.yml` (schema in `config/schema`). Main keys:

| Key | Default | Meaning |
|---|---|---|
| `location` | `content` | where buttons appear: `content` = extra display field on nodes; `links` = per view mode (see `sharethisnodes`); other = don't render on nodes, use the blocks. |
| `node_types` | `{article: article, page: page}` | which content types get buttons (map `bundle: bundle`). |
| `sharethisnodes` | `{article: {full: full}, page: {full: full}}` | when `location: links`, which `<bundle>.<view_mode>` show buttons. |
| `button_option` | `stbc_button` | button family/style. |
| `service_option` | `'"Facebook:facebook","Tweet:twitter",…'` | ordered list of services shown. |
| `widget_option` | `st_multi` | widget style. |
| `option_extras` | Google Plus One / Facebook Like map | extra buttons. |
| `option_onhover` | `1` | expand sharing menu on hover. |
| `option_shorten` | `1` | shorten shared URLs. |
| `option_neworzero` | `0` | open in new window / count from zero. |
| `twitter_handle` / `twitter_recommends` / `twitter_suffix` | `''` | Twitter extras appended to tweets. |
| `late_load` | `0` | defer the ShareThis script. |
| `comments` | `0` | include on comments. |
| `weight` | `10` | render weight of the buttons on the node. |
| `publisherID` | (unset) | ShareThis publisher id. |
| `cns` | `{donotcopy: , hashaddress: }` | copy-n-share options. |

## drush snippets

```bash
drush config:get sharethis.settings

# render buttons only per-view-mode instead of inside node content
drush config:set sharethis.settings location links -y

# only put buttons on the article content type
drush config:set sharethis.settings node_types.page 0 -y

# set a twitter handle appended to shares
drush config:set sharethis.settings twitter_handle 'mysite' -y
```

## How `location` drives rendering (from `sharethis.module`)

- `content`: `sharethis_entity_extra_field_info()` adds a `sharethis` display component to each
  node bundle; `sharethis_node_view()` renders it when the bundle is enabled in `node_types`
  and the component is visible on the view display. Suppressed for `search_result`,
  `search_index`, `rss` view modes.
- `links`: `sharethis_node_view()` renders buttons for the bundle/view-mode pairs enabled in
  `sharethisnodes.<bundle>`.
- otherwise: nothing on nodes — place `sharethis_block` / `sharethis_widget_block`
  (see [../plugins/blocks-and-views.md](../plugins/blocks-and-views.md)).

## Permission

```yaml
administer sharethis:
  title: 'Administer Sharethis'
  description: 'Change the settings for how ShareThis behaves on the site.'
  restrict access: TRUE
```
