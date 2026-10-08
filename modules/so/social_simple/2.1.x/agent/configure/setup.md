# Configure — displaying share links

There is no central settings page. Two independent display mechanisms.

## A) Per content type (node display element)
On the node-type edit form (`/admin/structure/types/manage/<type>`), the module adds a **"Social
simple share"** vertical-tab section, visible only to users with `administer social simple` **or**
`administer nodes`. Fields map to `node.type.<type>` third-party settings under `social_simple`:

| Setting | Form field | Meaning |
|---|---|---|
| `share` | "Display social network share links" | Master on/off for this content type. |
| `title` | "The title used above the share links" | Heading shown above the buttons. |
| `networks` | "Select the social networks available…" | Checkboxes of network ids to show. |
| `hashtags` | "Twitter hashtags" | An entity-reference field on the bundle whose referenced labels become Twitter `hashtags` (spaces stripped, comma-joined). |
| `forward_integration` | (only if `forward` module installed) | Integrate the Forward module with the Mail button. |

When `share` is on, the module exposes a **`social_simple_buttons`** pseudo-field via
`hook_entity_extra_field_info`. It is **hidden by default** — enable/position it on **Manage display**
(`/admin/structure/types/manage/<type>/display`) for the view modes where you want the buttons.
`hook_node_view` also renders the buttons automatically when `share` + `networks` are set and the
component is visible.

Config (per node type) example:
```
# node.type.article.yml → third_party_settings:
third_party_settings:
  social_simple:
    share: 1
    title: 'Share on'
    networks: { twitter: twitter, facebook: facebook, linkedin: linkedin }
    hashtags: field_tags
```

## B) Block
Place the **"Social simple block"** (`social_simple_block`) in any region. Block settings
(`block.settings.social_simple_block`): `social_share_title` (heading) and `social_networks`
(checkboxes). The block derives the shared entity from the current route (`node`, `taxonomy_term`,
or the first entity route parameter) and adds that entity's cache tags; cache context `url.path`.

## Networks available
`twitter` (X), `facebook`, `linkedin`, `googleplus`, `mail`, `printer` (browser print),
`entity_print_pdf` (needs the Entity Print module; otherwise the button is a no-op link). Twitter
reads hashtags from the configured field on nodes only.

## Per-node hiding (submodule `social_simple_per_node`)
Enable `social_simple_per_node` to add a `social_share` boolean base field to nodes and a
node-form checkbox "Social share links enabled" (inside the same "Social share" group). Users need
`disable social links per node` or `administer nodes` to see the checkbox; others get the content
type's default. When unchecked (value 0), `hook_node_view` skips rendering the buttons for that node.
Permission: `disable social links per node`.

## Theming
Buttons render through `#theme => 'social_simple_buttons'` (preprocessed like core links). Override
`templates/social-simple-buttons.html.twig`; a per-type suggestion `social_simple_buttons__<type>`
is added on node routes. Library `social_simple/buttons` opens links in a popup and pulls FontAwesome
6 icons from the jsDelivr CDN.
