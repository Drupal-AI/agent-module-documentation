# Installation

## Requirements

- **Drupal 10.4 or 11.1** (`core_version_requirement: ^10.4 || ^11.1`).
- The **AI** module (`ai`) — this provider plugs into the AI stack.
- The **AI Automators** module (`ai_automators`, part of the AI project) — the
  extraction is exposed for use in automator flows.
- The **Key** module (`key`) — used to store the Google Document AI credentials
  securely.
- A **Google Cloud** project with Document AI enabled and a credential (service
  account / API key) you can supply to the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_document_ocr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI, AI
Automators and Key dependencies and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_document_ocr -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_document_ocr -y
```

This also enables the AI, AI Automators and Key modules if they are not already
on.

## Store the Google credentials safely

Keep the Google Document AI credential out of version control and out of plain
config:

1. Save the value into an environment variable with DDEV's dotenv command, for
   example `ddev dotenv set .ddev/.env --google-docai-key=<value>`, then
   `ddev restart`.
2. Create a **Key** entity that reads from that environment variable (the Key
   module ships an env provider).
3. Point the Google Document AI provider at that Key when you configure it in
   the AI module.

Never paste the credential directly into a settings field.
