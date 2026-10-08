# Place & configure Copyright Block

There is no admin settings route (`configure: null`). Configuration is per **block instance**,
with site-wide defaults in the `copyright_block.settings` config object.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the target region (e.g. Footer) click **Place block** and choose **Copyright block**.
3. Configure and save.

## Block form fields (`CopyrightBlock::blockForm`)

| Field | Type | Notes |
|---|---|---|
| Start year | `number` (1900–current) | required; the first year of the range |
| Separator | `textfield` | required; printed between start and current year (default `-`) |
| Copyright statement text | `text_format` | required; the message body, run through a text format |

A token-tree link is shown so you can insert `[copyright_statement:dates]`. **Keep that token in
the text** — it is what renders the year(s).

## The `[copyright_statement:dates]` token

Defined in `copyright_block.module` (`hook_token_info` / `hook_tokens`), type
`copyright_statement`, token `dates`. Output:
- `start_year` alone when `start_year == current year`;
- `start_year<separator>current_year` when the current year is later (e.g. `2015 - 2026`).

The current year is `date('Y')` at render time, so the range updates automatically. The token
is resolved via `token->replace($text, ['config' => $config])` inside `CopyrightBlock::build()`
— it needs the block's own `config` context, so it only works inside this block's text (not in
arbitrary token contexts elsewhere).

## Site defaults (`copyright_block.settings`)

`config/install/copyright_block.settings.yml` seeds `separator: '-'`, `text.value: 'Copyright'`,
`text.format: basic_html`, `start_year: ''`. New block instances default `start_year` to the
current year and pull `separator`/`text` from this config (`CopyrightBlock::defaultConfiguration`).
Edit with `drush cset copyright_block.settings separator ' – ' -y`, etc.
