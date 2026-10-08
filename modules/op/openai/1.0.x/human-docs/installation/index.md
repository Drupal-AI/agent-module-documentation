# Installation

## Requirements

OpenAI Core needs the official OpenAI PHP client:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`openai-php/client`** PHP library (`>=v0.7.8`), which Composer installs for
  you.
- An **OpenAI API key** (create one in your OpenAI account) — see
  [Configuration](../configuration/index.md).

Individual submodules may add their own requirements (for example, OpenAI Embeddings
needs a Milvus or Pinecone backend for vector search).

## Install with Composer

From the project root:

```bash
composer require drupal/openai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `openai-php/client`
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openai -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en openai -y
```

By itself the base module only provides the API key settings and the shared
`openai.api` service. Until you add a key, administrators see a warning on admin
pages — that is expected. Set up the key next
([Configuration](../configuration/index.md)).

## Submodules — enable only the features you need

OpenAI Core ships eleven submodules. The base module is plumbing; these provide the
actual features and each adds its own routes, permissions, and forms:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **OpenAI Content** | `openai_content` | AI content tools on the node form (summarize, adjust tone, suggest titles/taxonomy). |
| **OpenAI CKEditor** | `openai_ckeditor` | An OpenAI completion button inside CKEditor 5, streaming into the editor. |
| **OpenAI ChatGPT** | `openai_chatgpt` | A ChatGPT explorer form. |
| **OpenAI Prompt** | `openai_prompt` | A prompt/completion explorer form. |
| **OpenAI DALL·E** | `openai_dalle` | Image generation from a prompt. |
| **OpenAI Audio** | `openai_audio` | Whisper audio transcription. |
| **OpenAI TTS** | `openai_tts` | Text‑to‑speech synthesis. |
| **OpenAI Embeddings** | `openai_embeddings` | Semantic/vector search backed by Milvus or Pinecone. |
| **OpenAI DBLog** | `openai_dblog` | AI analysis of Drupal log messages. |
| **OpenAI ECA** | `openai_eca` | OpenAI actions for ECA workflows. |
| **OpenAI Devel** | `openai_devel` | Demo content generation via Devel Generate. |

Enable the ones you want, for example:

```bash
drush en openai_ckeditor openai_content -y
```

## Verify it worked

Go to **Configuration → OpenAI → Settings** (`/admin/config/openai/settings`). You
should see the API key form. Once you enter a key, the **Models** page
(`/admin/config/openai/settings/models`) should list the models available to your
account. Next, see [Configuration](../configuration/index.md).
