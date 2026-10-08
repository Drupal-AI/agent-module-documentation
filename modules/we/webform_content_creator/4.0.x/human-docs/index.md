# Webform Content Creator — manual setup guide

**Webform Content Creator** (`webform_content_creator`) automatically turns webform
submissions into real content. Whenever someone submits a webform you've wired up,
the module creates a content entity — a node by default, or any other entity
type/bundle — and fills its fields from the submission's values. An "Submit an
event" form becomes an Event node; a contact form becomes a Lead entity; a help
request becomes a support‑ticket node — all without a developer writing submission
handlers.

The heart of it is a **mapping**. For each configuration you create, you pick a
source webform and a target content type, then map submission fields onto content
fields: this webform text field becomes the node title, that textarea becomes the
body, a select becomes a taxonomy reference, and so on. You can feed a field
directly from a submission value or from a **token** string (so the title could be
`[webform_submission:values:subject]`, for instance), and there's a handy
`[webform_submission:unmapped_values]` token that dumps everything you didn't map
elsewhere into, say, a body field. Field values are applied through type‑aware
mapping plugins, so entity references, dates, addresses, links, emails, and more are
handled correctly.

Beyond simple creation, it can keep things in sync: update the created content when
its submission is edited, delete it when the submission is deleted, or match an
existing entity by a unique field and update it instead of making a duplicate. You
can encrypt sensitive mapped values via the Encrypt module, and redirect the
submitter to their newly created content with a custom message. It's a flexible way
to build moderated content pipelines, CRM‑style lead capture, or directory listings
maintained through a form.

The module requires the [Webform](https://www.drupal.org/project/webform) module
and provides a permission that controls who can manage these mappings. Everything is
configured through its own admin section and stored as exportable configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a mapping, map the fields, and
   set the sync, encryption, and redirect options.

## Where it lives in the admin menu

The module's admin section is at **Configuration → Webform Content Creator**
(`/admin/config/webform_content_creator`), gated by the **Access Webform Content
Creator configuration** permission. Each configuration has its own **Manage fields**
form beneath it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Add a configuration that binds a webform to a target content type.
3. On its **Manage fields** form, set the content title and map each webform
   element to a content field.
4. Submit the webform — the content is created automatically.

See [Configuration](configuration/index.md) for the step‑by‑step.
