# Configuration

Tealium iQ's settings live at **Configuration → Web services → Tealium iQ**
(`/admin/config/services/tealiumiq`). You need the **administer tealium settings**
permission to open the form — and remember that permission is restricted for good
reason, since it controls what runs on every page.

## Point Drupal at your Tealium container

On the settings form you connect Drupal to your Tealium container by entering the
account details your Tealium administrator gives you — the **account**, **profile**
and **environment** that together identify which container's `utag` loader to
embed. You can also choose whether tags load **synchronously or asynchronously**,
which affects how the loader is injected into the page.

Once these details are saved, the module embeds the Tealium loader on your pages
and begins building the data layer for its tags to read.

## Manage default tags and the data layer

The admin interface lets you manage the **default Tealium tags** that apply across
the site. Tealium ships basic coverage of commonly used tags, and the module
exposes a set of standard fields so you can supply values for them.

Because the module integrates with the **Token** module, you can populate tag
values with tokens instead of hard‑coding them — click the token browser to see
what is available, and choose tokens that resolve from the entity being viewed
(content type, section, author, publication date, product identifier, and so on).
That way the data layer describes each page automatically.

For per‑entity values, the module uses standard fields, so the values you set on an
individual entity translate and version like any other content.

## Two things to keep in mind

- **Consent applies to the whole container.** Integrate Tealium with your consent
  manager rather than assuming the container handles consent on its own.
- **The data layer is a disclosure.** Everything you put into it is readable by
  every tag in the container and by anyone viewing the page source. Do not place
  personal data in the data layer unless you have deliberately decided to expose
  it.

## Save

Click **Save configuration** to store your settings. Reload a front‑end page and
view its source to confirm the Tealium loader is present and the data layer is
populated as you expect.
