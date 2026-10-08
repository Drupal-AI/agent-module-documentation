# Meta tags on Views displays

Integrates Metatag with Views so non-entity listing/archive/search pages can carry meta
tags.

- Enable the Metatag **display extender** for the View (Views settings, or it appears on
  the display's "Advanced" / "Other" section).
- Configure title/description/OG and other tags per display; values are token-enabled and
  can reference View arguments and contextual filters.
- Any enabled tag submodule's tags (Open Graph, Twitter, etc.) are available.
- Stored in the View's configuration. Schema: `config/schema/metatag_views.views.schema.yml`.
