# Configuration

Configurable Help doesn't have a single "settings" screen — instead you manage a
collection of **help topics**, each of which is a configuration entity you create
and edit through the admin UI. This page walks through that form field by field.

## Open the topic collection

1. Log in as a user with the **administer config help** permission.
2. Go to **Configuration → Development → Configurable Help**, or navigate directly
   to `/admin/config/development/config-help`.

You'll see the list of configurable topics with **Add**, **Edit**, and **Delete**
actions.

## Add or edit a topic

Click **Add** (or **Edit** on an existing topic). The form has these fields:

- **Label** — the human-readable title of the topic, shown in help listings and at
  the top of the topic page.
- **Machine name / id** — the unique identifier for the topic (Drupal usually
  derives this from the label). It's how other topics reference this one.
- **Top-level** — a flag marking whether the topic is a top-level entry. Top-level
  topics are listed directly on the main Help page (`/admin/help`); non-top-level
  topics are reached as related topics from others.
- **Related topics** — a field where you link other topics as "see also" entries.
  It uses an **autocomplete** (backed by `/config-help/autocomplete-topic`) so you
  can type to find existing topic ids rather than remembering them.
- **Body** — the content of the topic, written as HTML and rendered through a text
  format. The default format is `help`. (Behind the scenes the body is stored in
  chunks so it round-trips cleanly through configuration schema — you don't need to
  do anything special for that to work.)
- **Text format** — the format used to render the body; choose one your role is
  allowed to use.

## Save

Click **Save**. The topic is stored as configuration and appears on the standard
Help pages — top-level topics on `/admin/help`, others as related links —
intermixed with the read-only topics that modules and themes provide.

## Translate, export, and import

Because each topic is a config entity:

- With **Configuration Translation** enabled, an additional **Translate** option
  lets you provide the label and body in other languages.
- Topics are included in your normal configuration export
  (`drush config:export`), so you can version them in code and import them into
  another environment (`drush config:import`) like any other config.

Remember that only topics you create here are editable — topics provided by modules
or themes remain read-only.
