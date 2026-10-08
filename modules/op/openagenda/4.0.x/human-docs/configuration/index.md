# Configuration

OpenAgenda needs to know how to reach your OpenAgenda account before it can
display any events. That connection is set up on the module's settings form, and
the events themselves are attached to content through the OpenAgenda field.

## OpenAgenda settings

Open the module's settings form at **Configuration → Web services → OpenAgenda**
(`/admin/config/services/openagenda`, route `openagenda.form`). Access to this
form is controlled by the **Administer OpenAgenda** permission, so grant that only
to trusted roles at **People → Permissions**.

Key options on the form:

- **OpenAgenda public key** — the public key from your OpenAgenda account. The
  module stores it in its configuration and uses it only on the server, through
  the `openagenda/sdk-php` SDK, to request data from `api.openagenda.com`. When
  you save the form, the module contacts OpenAgenda to confirm the key is valid
  and that it can list your agendas. Because this value is part of exported
  site configuration, treat configuration exports the same way you treat the rest
  of your site config.
- **General settings** — navigation context (adds *Next*/*Previous* links between
  search results), a usage‑tracking opt‑in (sends the CMS name and your site's
  host to OpenAgenda for statistics), manual submit (don't re‑search
  automatically when filters change), and a simple date‑range field option.
- **Default content settings** — events per page, default language, whether to
  include embedded HTML in descriptions, current/upcoming‑only, and a text‑search
  relevance threshold (Off / Auto / Custom score).
- **Display and filter defaults** — default style and column count, plus default
  labels/placeholders for the map and search filters.

## Attach an agenda to content

Either use the default **OpenAgenda** content type that ships with the module, or
add an **OpenAgenda field** to an existing content type at **Structure → Content
types → *(type)* → Manage fields**, then set its widget and formatter under
**Manage form display** and **Manage display**. Enter the agenda's UID on the
content (you can also override per‑field settings such as language, events per
page, prefilter and threshold), and the events will render.

## Add filter blocks

To let visitors filter the events, place any of the filter blocks at **Structure
→ Block layout** (`/admin/structure/block`): map, calendar, cities, keywords,
favorites, relative date, text search, and additional field, plus sort, submit,
total‑results and active‑filters blocks. On event pages you can also place the
event map and event timetable blocks. Place only the blocks you need, in the
region where you want them to appear. The map filter, search filter and
additional‑field filter blocks have extra options in their own block settings.

## Test it

Load a page that displays an OpenAgenda agenda and confirm events appear. If they
don't, re‑check the public key and agenda UID, confirm you are a member of that
agenda, and remember that event availability depends on the external OpenAgenda
service and its API.
