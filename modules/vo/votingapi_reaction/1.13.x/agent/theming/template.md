<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: the `votingapi_reaction_item` template

The module registers one theme hook (`hook_theme` in `votingapi_reaction.module`),
`votingapi_reaction_item`, rendered by `templates/votingapi-reaction-item.html.twig`. Each reaction
button in the AJAX form is rendered through this hook by
`VotingApiReactionManager::getReactions()`.

## Variables

| Variable | Meaning |
|---|---|
| `reaction` | The reaction vote-type id. |
| `icon_type` | `uploaded_image` \| `remote_image` \| `html_element` — selects which markup branch renders. |
| `icon_alt` | Alt / aria-label text (the vote type label). |
| `icon_class` | CSS class for the icon (prefixed with `votingapi-reaction-image` in the template). |
| `uploaded_image` | URL of the uploaded/default icon (used when `icon_type` is `uploaded_image`). |
| `remote_image` | Remote icon URL (used when `icon_type` is `remote_image`). |
| `html_element` | Tag name (`i`/`span`/`div`) rendered when `icon_type` is `html_element`. |
| `label` | Reaction label (rendered in `.votingapi-reaction-label` when set). |
| `count` | Per-reaction count (rendered in `.votingapi-reaction-count` when not empty). |
| `icon` | **Legacy** — the uploaded-icon URL, kept for back-compat with older template overrides. |

## Override it

Copy `templates/votingapi-reaction-item.html.twig` into your theme and adjust markup/classes. The
shipped template wraps everything in `.votingapi-reaction-item-wrapper` > `.votingapi-reaction-item`,
emits an `<img>` for image icon types or the chosen `html_element` for the element type, then the label
and count. The reaction radio form itself carries class `votingapi-reaction-form` and attaches the
`votingapi_reaction/scripts` library (jQuery + `core/drupal.ajax` + the module CSS). CSS lives in
`css/votingapi_reaction.css`; the shipped SVG icons are in `svg/`.

Base CSS/JS is provided by the `votingapi_reaction/styles` and `votingapi_reaction/scripts` libraries
(`votingapi_reaction.libraries.yml`).
