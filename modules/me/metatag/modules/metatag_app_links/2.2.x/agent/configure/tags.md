# App Links tags

Adds the "App Links" MetatagTag group. Set them in any Metatag defaults entity or the
per-entity Metatag field; all support tokens.

Platforms & key tags:
- **iOS / iPhone / iPad** — `al:ios:url`, `al:ios:app_store_id`, `al:ios:app_name` (and `al:iphone:*`, `al:ipad:*`).
- **Android** — `al:android:url`, `al:android:package`, `al:android:class`, `al:android:app_name`.
- **Windows / Windows Phone / Windows Universal** — `al:windows:url`, `al:windows:app_id`, `al:windows:app_name` (+ `al:windows_phone:*`, `al:windows_universal:*`).
- **Web fallback** — `al:web:url`, `al:web:should_fallback`.

Emitted as `<meta property="al:…" content="…">`. Schema: `config/schema/metatag_app_links.metatag_tag.schema.yml`.
