# Configuration

OpenAgenda needs to know how to reach your OpenAgenda account before it can
display any events. That connection is set up on the module's settings form, and
the events themselves are attached to content through the OpenAgenda field.

## Handle the API key as a secret

Your OpenAgenda API key authenticates your site to the service, so keep it out of
anything you commit to version control. If you run DDEV, a clean approach is to
store the value in the environment and never commit `.ddev/.env`:

```bash
ddev dotenv set .ddev/.env --openagenda-api-key=<your-key>
ddev restart
```

Then supply the key to the settings form below.

## OpenAgenda settings

Open the module's **OpenAgenda settings** form (route `openagenda.form`). Here you
provide the details the module needs to talk to the platform:

- **OpenAgenda API key** — the key from your OpenAgenda account, used to
  authenticate requests to the service.
- **Agenda identifier (UID)** — which OpenAgenda agenda to pull events from. You
  can also set the agenda UID per field when you attach an OpenAgenda field to a
  content type.

Save the form. Grant the module's permissions to the appropriate roles at
**People → Permissions** so the right users can manage OpenAgenda content.

## Attach an agenda to content

Either use the default **OpenAgenda** content type that ships with the module, or
add an **OpenAgenda field** to an existing content type at **Structure → Content
types → *(type)* → Manage fields**, then set its widget and formatter under
**Manage form display** and **Manage display**. Enter the agenda's UID on the
content, and the events will render.

## Add filter blocks

To let visitors filter the events, place any of the eight filter blocks at
**Structure → Block layout** (`/admin/structure/block`): map, calendar, per‑tag,
relative date, text search, favorites, keywords, and additional field. Place only
the filters you need, in the region where you want them to appear.

## Test it

Load a page that displays an OpenAgenda agenda and confirm events appear. If they
don't, re‑check the API key and agenda UID, and remember that event availability
depends on the external OpenAgenda service and its API.
