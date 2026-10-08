# Configuration

You configure Webform Content Creator by creating one or more **configurations**,
each of which binds a webform to a content type and describes how to map fields.
This page walks through creating one and mapping its fields, then covers the sync,
encryption, and redirect options.

## Open the admin section

1. Log in as a user with the **Access Webform Content Creator configuration**
   permission.
2. Go to **Configuration → Webform Content Creator**
   (`/admin/config/webform_content_creator`). You'll see a list of existing
   configurations (empty at first).

## Step 1 — Add a configuration

Click **Add configuration** and fill in:

- **Title** — a label for this configuration (also used to generate its machine
  name).
- **Webform** — the source webform whose submissions will trigger content creation.
- **Content type** — the target bundle to create (for example *Article*). By
  default the target entity type is **node**; the module can target other content
  entity types too.

Save to create the configuration.

## Step 2 — Manage fields

Open the configuration's **Manage fields** form
(`.../manage/{id}/fields`). This is where the mapping happens:

- **Title** — set the title the created content will get. You can type a static
  value or use tokens, for example `[webform_submission:values:subject]` to reuse a
  webform field.
- **Field mapping** — the form lists the target content type's fields. Tick each
  field you want to populate, then for each one choose either:
  - the **webform element** whose submitted value should feed it, or
  - a **custom value** — a token string you supply instead of a direct webform
    value.

  Each field also has a **mapping plugin** appropriate to its type. The
  **default** mapping works for most fields, and there are type‑aware mappings for
  entity references, datetimes, addresses, links, emails, booleans, numbers, and
  text so those field types are populated correctly. Pick the mapping that matches
  the field.

There's also a special token, `[webform_submission:unmapped_values]`, that renders
every submission value you didn't map elsewhere — useful for pushing "everything
else" into a body field.

Save the mapping. From now on, each (non‑draft) submission of that webform creates
a piece of content according to your mapping.

## Synchronization options

On the configuration's settings you can keep content in step with submissions:

- **Update content on submission edit** — when a submission is edited, update the
  content that was created from it, rather than leaving a stale copy.
- **Delete content on submission delete** — when a submission is deleted, delete
  its created content too.
- **Update existing content by a unique field** — instead of creating a new entity
  every time, match an existing one on a nominated field and update it. You choose
  which content field holds the submission identifier used for this matching. This
  is how you deduplicate rather than pile up duplicates.

## Encryption

If you handle sensitive data, enable **encryption** and select an **encryption
profile**. This requires the [Encrypt](https://www.drupal.org/project/encrypt)
module; mapped values are then encrypted using the chosen profile.

## Redirect after submission

- **Redirect to the created entity** — send the submitter straight to the content
  that was just created.
- **Redirect messages** — set the confirmation message shown on creation, and a
  separate one shown when an existing entity is updated.

## Deploying configurations

Each configuration is stored as Drupal configuration
(`webform_content_creator.webform_content_creator.<id>`), so you can export it and
deploy it between environments like any other config — no Drush command is needed.
