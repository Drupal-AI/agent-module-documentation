# Configuration

Smart Trim has **no global settings form**. Everything is configured per field,
per view mode, on the **Manage display** screen — so the "same" body field can be
trimmed one way in a Teaser and another way in a Card, for example.

## Open the formatter settings

1. Log in as a user who can administer display settings (an administrator by
   default).
2. Go to **Structure → Content types → *(your type)* → Manage display**
   (`/admin/structure/types/manage/<bundle>/display`). Pick the **view mode** you
   want (e.g. *Teaser*) from the tabs or the "Custom display settings" section.
3. Find a supported field — `text`, `text_long`, `text_with_summary`, `string`,
   or `string_long` — and set its **Format** to **"Smart trimmed"**.
4. Click the **gear icon** on that row to open the settings, adjust them, click
   **Update**, then **Save** the page.

These settings are saved with the entity view display configuration (schema
`field.formatter.settings.smart_trim`), so they export and deploy with the rest of
your display config.

## Trim length and type

- **Trim length** (`trim_length`, default **600**) — how much of the text to keep.
  Required; minimum 0.
- **Trim units** (`trim_type`, default **characters**) — measure the length in
  **characters** or in **words**. Words often produce cleaner cuts because they
  never split mid-word.
- **Suffix** (`trim_suffix`, default empty) — text appended when the content is
  actually trimmed, such as an ellipsis (`…`). It supports `\uXXXX` escape
  sequences.

## Summary handling (text-with-summary fields only)

For `text_with_summary` fields, **Summary handler** (`summary_handler`, default
**Use summary**) controls what happens when the field already has an editor-written
summary:

- **Full** — use the existing summary as-is, without trimming it.
- **Trim** — use the summary but still apply the trim length to it.
- **Ignore** — never use the summary; always trim the full body.

## Trim options

Three checkboxes fine-tune the truncation:

- **Strip HTML** (`trim_options.text`) — remove all HTML to produce a plain-text
  excerpt (handy for meta descriptions or social previews).
- **Honor a zero trim length** (`trim_options.trim_zero`) — respect a
  `trim_length` of 0 to suppress the body output entirely (while still allowing a
  summary, per the handler above).
- **Replace tokens before trimming** (`trim_options.replace_tokens`) — run token
  replacement on the content before it's trimmed.

## The "Read more" (More) link

- **Display more link** (`more.display_link`, default **off**) — add a link to the
  entity's canonical page. The link only renders when the entity has an ID and a
  canonical URL.
- **Link text** (`more.text`, default **More**) — the link label; supports tokens
  (e.g. `[node:title]`).
- **Only when trimmed** (`more.link_trim_only`, default **off**) — show the link
  only when the text was actually shortened.
- **Open in new window** (`more.target_blank`, default **off**) — open the link in
  a new browser tab/window.
- **CSS class** (`more.class`, default **more-link**) — a class on the link for
  styling.
- **Aria-label** (`more.aria_label`, default **Read more about [node:title]**) — an
  accessible label for screen readers; supports tokens.

## A note on the wrapper option

Older versions offered **Wrap output** (`wrap_output`) and a **Wrap class**
(`wrap_class`, default `trimmed`) to wrap the output in a `<div>`. This option is
**deprecated and will be removed in 3.0** — override the `smart-trim.html.twig`
template instead if you need custom markup.
