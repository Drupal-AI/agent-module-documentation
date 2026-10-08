# Theming

Buttons render through two Twig templates (copy to your theme to override):

| Template | Theme hook | Used for |
|---|---|---|
| `templates/addtoany-standard.html.twig` | `addtoany_standard` | Per-entity share buttons. |
| `templates/addtoany-follow.html.twig` | `addtoany_follow` | Follow block buttons. |

`addtoany_standard` variables: `addtoany_html`, `link_url`, `link_title`, `buttons_size`,
`button_setting`, `button_image`, `universal_button_placement`, `entity_type`, `bundle`.
`addtoany_follow` variables: `addtoany_html`, `buttons_size`, `entity_type`, `bundle`.

**Theme suggestions** are provided per entity type and bundle, e.g.
`addtoany-standard--node.html.twig`, `addtoany-standard--node--article.html.twig`
(`hook_theme_suggestions_addtoany_standard`/`_addtoany_follow`), so you can style share buttons
differently per content type.

**Positioning:** buttons are exposed as an extra (pseudo) field via
`hook_entity_extra_field_info`, so their placement is controlled on each entity's
**Manage Display** screen alongside real fields. The front-end widget loads AddToAny's external
`page.js` plus `js/addtoany.js` and `css/addtoany.css` (library `addtoany.front`).
