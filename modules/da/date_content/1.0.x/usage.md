<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Content Augmenter lets you attach your own fielded content to a single value of a date field, shown inline wherever that date is rendered.

---

Install it with Composer (`composer require drupal/date_content`) alongside its dependency **Date Augmenter**, then enable both. On install the module creates a **Date Content** entity type and a starter bundle called **Session** (with example *Topic* and *Speaker* fields); you can edit that bundle's fields at `/admin/structure/date_content_types/session/edit/fields`, or delete it and build your own bundles at `/admin/structure/date_content_types/add` with whatever fields you need (plain fields for simple cases, entity-reference fields for richer models such as a Speaker or Location entity). The behaviour is switched on **per date-field formatter**: go to *Manage display* for the entity that has the date field, open the formatter settings, and enable the **Content** augmenter that Date Augmenter exposes there. In the augmenter settings you choose which Date Content bundle(s) may be added, whether to show content and links for past events, and whether the add/edit forms open on a normal page, in a **modal**, or in an **off-canvas tray** (with a configurable width). When the date renders, each value gains an **Add** link (or the existing content plus **Edit**/**Remove** links) for viewers with the relevant permission — `add`, `edit`, `delete`, or `administer date content entities`. Although designed with **Smart Date** in mind, it works with any date field whose formatter supports Date Augmenter, including core date fields, and because it uses the augmenter API it coexists with other augmenters (such as an add-to-calendar link) on the same date. The current release is **1.0.0-alpha8** (alpha), so evaluate it against your editorial roles before production use.

---

- Attach a topic and speaker to each occurrence of a recurring monthly meeting.
- Add a per-session note explaining why one date in a series differs.
- Link a source document to a specific historical date on a timeline.
- Attach guidance for meeting a particular deadline date.
- Associate a different location entity with each date of an event series.
- Use entity-reference fields to reuse a Speaker or Location across dates.
- Show related content inline wherever a date field is rendered.
- Compose the Content augmenter alongside an add-to-calendar augmenter on one date.
- Augment core date fields, not just Smart Date fields.
- Create a custom Date Content bundle with your own fields.
- Edit the starter Session bundle's Topic and Speaker fields.
- Delete the Session bundle and start from a clean bundle.
- Open the add/edit form in a modal dialog.
- Open the add/edit form in an off-canvas settings tray.
- Set the dialog width for modal or tray forms.
- Limit which bundles can be added on a given date field.
- Hide content and links once an event is in the past.
- Restrict who may add, edit, or delete date content by permission.
- Track revisions of date content per bundle.
- Translate date content into multiple languages.
- List and administer all date content at /admin/content/date_content.
- Build Views over Date Content using the bundled Views wizard.
