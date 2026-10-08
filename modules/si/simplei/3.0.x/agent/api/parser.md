# API — IndicatorParser & rendering

## The parser service

Service id **`Drupal\simplei\IndicatorParser`** (registered by class name).

```php
/** @var \Drupal\simplei\IndicatorParser $p */
$p = \Drupal::service(\Drupal\simplei\IndicatorParser::class);
[$foreground, $background, $environment] = $p->parse('@staging');
// -> ['#ffffff', 'GoldenRod', 'staging']
```

`parse(string $indicator): array` returns a 3-element indexed array
`[foreground, background, environment]`, all HTML-escaped. Defaults before parsing:
`foreground = #ffffff`, `background = #999999`, `environment = 'SITE'` (used if the string has no
label). Logic:

- Starts with `@` → predefined color chosen by `match(strtolower(substr($env,0,2)))`
  (`pr`/`li` → FireBrick or `#8b0000` with `#access`; `st`/`te` → GoldenRod / `#59590d`;
  `de` → `#0057ad` / `#005b94`; default → DodgerBlue / `#4a0080`). `#access` selects the darker set.
- Otherwise `preg_match('/(\S+)\s+(.*)/')` splits `<color> <label>`; if the color part contains
  `/` it is `foreground/background`, else it is the background (foreground stays white).

The parser is pure and side-effect free — safe to call for any indicator string.

## How the module renders (two paths)

Both read `Settings::get('simple_environment_indicator')`, bail if empty, then call the parser.

1. **Core Navigation top bar** — `Plugin/TopBarItem/EnvironmentIndicator` (id
   `simplei_environment_indicator`, region `Context`) builds a `<span class="simplei-indicator
   top-bar__title">` with CSS vars `--simplei-fg` / `--simplei-bg`, attaching the
   `simplei/navigation` library. Active when the `navigation` module is on and the user has
   `access navigation`.
2. **Classic Toolbar** — `SimpleiHooks::pageAttachments()` (`hook_page_attachments`) sets
   `drupalSettings.simplei = {color, background, environment}` and attaches the `simplei/simplei`
   JS library. Used when navigation is *not* active but `toolbar` is and the user has
   `access toolbar`. The hook deliberately skips this path when navigation is active so the badge
   is not shown twice.
3. **Anonymous** — when neither toolbar/navigation applies and
   `simple_environment_anonymous` is set, an inline `<style>` banner is injected via
   `html_head`.

`SimpleiHooks` is an autowired hook class (`#[Hook('help')]`, `#[Hook('page_attachments')]`), with
the legacy `.module` functions delegating to it via `#[LegacyHook]`.
