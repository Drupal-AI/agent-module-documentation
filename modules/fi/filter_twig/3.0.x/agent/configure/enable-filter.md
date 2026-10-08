# Enabling the Twig filter on a text format

There is **no settings form** (`configure` = null). The module is turned on per text format.

## Steps (UI)

1. Go to `/admin/config/content/formats`.
2. Edit (or add) a text format — ideally one whose "use" permission is limited to trusted
   roles (e.g. Full HTML, or a dedicated admin-only format).
3. Under **Enabled filters**, tick **"Replaces Twig values"** (`filter_twig`).
4. Save the format. Fields using that format now render their content as Twig.

## Where it is stored

In the `filter.format.<format_id>` config entity:

```yaml
filters:
  filter_twig:
    id: filter_twig
    status: true
    weight: <n>
    settings: {  }
```

Enable via Drush/code by loading the `FilterFormat`, calling
`setFilterConfig('filter_twig', ['status' => TRUE])`, and saving. `filters.filter_twig.status`
is the flag that turns Twig rendering on for that format.

## Filter ordering

`filter_twig` is `TYPE_TRANSFORM_IRREVERSIBLE`. Where it sits in the format's filter pipeline
(its `weight`) matters if you combine it with HTML-restricting filters — run Twig before
filters that would strip the markup it produces, and remember "Limit allowed HTML tags" can
still strip Twig output afterwards.

## Security caution (read before enabling)

The filter executes the field's text as a Twig template (`inline_template`). Anyone who can
**edit a field that uses a Twig-enabled format** can therefore run Twig. Only enable it on
formats whose `use text format <id>` permission is restricted to trusted/administrative roles.
Do **not** enable it on a format available to untrusted or anonymous users (e.g. a default
comment/basic format) — that would be arbitrary Twig execution by low-privilege users. On this
documentation site no text format currently enables `filter_twig`, so there is no live
exposure; keep it that way unless the format is admin-only.
