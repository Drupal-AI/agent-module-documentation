# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`) — the content the assistant answers from.
- Drupal's **AI** module, configured with a working **AI provider** and its API
  key stored via the **Key** module. The assistant calls this provider to
  generate answers.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_rag_assistant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_rag_assistant -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_rag_assistant -y
```

## After enabling

1. Make sure an **AI provider** is configured in the AI module with its API key
   stored as a Key (env‑backed), not in plain configuration.
2. At **People → Permissions**, grant the AI RAG Assistant permission to the
   roles that should be allowed to use the chatbot.
3. Expose the chatbot to those users and confirm its answers are drawn from your
   site content. Remember that questions and content are sent to your AI
   provider — confirm that egress is acceptable.
