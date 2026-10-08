<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `advent_calendar:door` component

A Single Directory Component (`components/door/`) rendering one calendar door. Used by the Views style's field
template but reusable via `{{ include('advent_calendar:door', { … }) }}`.

## Definition (`door.component.yml`)

- `libraryOverrides.dependencies`: `core/drupal`, `core/once` (so `door.js` gets the behavior + `once`).
- Props (`props.properties`):

| Prop | Required | Meaning |
|---|---|---|
| `calendar` | yes | Unique calendar id (e.g. year `"2023"`); part of the DOM id and storage key. |
| `day` | yes | The day number shown on the door. |
| `title` | yes | Title of the content behind the door (used as image `alt`). |
| `unlocked` | no | Renders clickable/open markup when its rendered text contains `True`. |
| `path` | no | URL the door links to (the content's page). |
| `door_image` | no | Image shown behind the door when open. |
| `door_closed_image` | no | Custom closed-door image (else shipped SVG). |
| `door_open_image` | no | Custom open-door frame image (else shipped SVG). |

## Twig (`door.twig`)

- Root: `<div id="advent-calendar-{{ calendar|striptags|trim }}-{{ day|striptags|trim }}" class="advent-calendar-door">`.
- `{% if 'True' in unlocked|render %}` → renders the **closed (clickable)** block plus the **open** block: a
  `door-link` `<a href="{{ path|striptags }}">` carrying `data-calendar` / `data-day`, the day number, the
  behind-door image (`door_image`), and the closed/open images (custom prop or the SVG at
  `/{{ componentMetadata.path }}/assets/advent_calendar_door_{closed,open}.svg`).
- `{% else %}` (unpublished/not unlocked) → a plain `door-closed` block with the closed image and day number, and
  **no link** — it cannot be opened.
- Values are piped through `striptags`/`trim` and rendered in Twig's autoescaping context.

## JS behavior (`door.js`)

`Drupal.behaviors.door` uses `once('component--door', '.door-link', context)` and for each link:

1. If `link.pathname === window.location.pathname`, marks that door open in `localStorage`
   (`advent_calendar_<calendar>_<day> = 'open'`) — i.e. visiting a door's own page opens it.
2. If the storage key is already `'open'`, adds the `open` class to `#advent-calendar-<calendar>-<day>`.
3. On `click`, sets the storage key to `'open'`.

Open/closed state is thus per-browser (localStorage) and purely presentational; it does not change what content
is accessible.

## CSS / assets

- `door.css` styles the flip between closed/open; `.open` (added by the behavior) reveals the open face.
- `assets/advent_calendar_door_closed.svg` and `advent_calendar_door_open.svg` are the default door images.
- The style template also attaches the module library `advent_calendar/advent_calendar` (`css/advent_calendar.css`)
  for the calendar grid.

## Overriding

Override `door.twig` via a theme's component override, or supply `door_closed_image` / `door_open_image` through
the Views style options to change the door art without touching Twig.
