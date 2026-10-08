# Installation

## Requirements

- **Drupal core 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal core's **User**, **File**, and **Image** modules (part of core).
- The **Flag** module (`flag`) — Composer will pull this in.
- Optional: the **AI** module and a configured chat‑capable provider (for example
  [AI Provider OpenAI](https://www.drupal.org/project/ai_provider_openai)), needed
  **only** if you want AI‑generated quick‑reply suggestions.

No external chat server, WebSocket server, Node.js service, Redis, or third‑party
messaging platform is required, and there are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/chat_messenger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — including the Flag module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chat_messenger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chat_messenger -y
```

## Grant permissions

Chat Messenger provides its own permissions. After enabling, go to **People →
Permissions** (`/admin/people/permissions`) and grant the appropriate chat
permissions to the roles that should be able to use messaging. Because the module
stores private messages and file uploads, grant chat access only to roles you
intend to give a messaging capability.

## Recommended setup

- Configure user **profile pictures** so avatars display (initial‑based avatars are
  generated when a user has no picture).
- Configure the **private file system** so uploaded attachments are stored
  securely.

## Verify it worked

Log in as a user in a role with chat permissions and browse the site. A floating
chat button should appear; clicking it should show available users and let you
start a conversation. Open a second browser (or account) to confirm messages
appear live without a page refresh.
