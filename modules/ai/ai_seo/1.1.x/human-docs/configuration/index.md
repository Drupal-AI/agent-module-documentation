# Configuration

Getting AI SEO running is three steps: connect an AI provider, choose the model for
SEO analysis, and grant permissions. After that you can manage the report types and
start analysing nodes.

## Step 1 — Configure an AI provider (in the AI module)

AI SEO cannot run until the AI module has a working provider.

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and set
   up a provider (for example OpenAI or Anthropic).
2. A provider needs an **API key**. Keep that key out of code and version control:
   store it in an environment variable and reference it through a **Key** entity
   rather than pasting it into config. On this project that means saving the value
   with DDEV's dotenv command and creating a Key with the built-in env provider —
   see the project's setup notes — then selecting that Key in the provider settings.

## Step 2 — Choose the provider and model for SEO

1. Log in as a user with the **Administer ai seo** permission.
2. Go to **Configuration → AI → AI SEO/GEO analyzer**, or navigate to
   `/admin/config/ai/seo`.
3. Set the fields:
   - **Provider and model** (`provider_and_model`) — the AI provider + model that
     powers the analysis (for example an OpenAI GPT model). Required for anything to
     run.
   - **Custom system prompt** (`custom_system_prompt`) — optional. Text prepended as
     a system prompt to every analysis, to steer the model site-wide.
   - **Custom prompt** (`custom_prompt`) — optional. Extra prompt text applied to
     every analysis.
   - **Enable field buttons** (`enable_field_buttons`) — when on, adds inline
     "SEO/GEO ✦" buttons to individual text field widgets, so editors can get
     focused advice on a single field.
4. **Save**.

## Step 3 — Set permissions

At **People → Permissions** (`/admin/people/permissions/module/ai_seo`):

| Permission | Grants |
|------------|--------|
| **View seo reports** (`view seo reports`) | Viewing saved reports, the "Analyze SEO" link, and the node-form sidebar. |
| **Create seo reports** (`create seo reports`) | Actually generating a report — this **calls the AI provider and costs money**, so grant it deliberately. |
| **Administer ai seo** (`administer ai seo`) | The global settings form. |
| **Administer ai seo settings** (`administer ai seo settings`) | Managing report types. |

## Managing report types

Each analysis is driven by a **report type** — a config entity you can inspect and
edit without any AI call.

1. Go to **Configuration → AI → AI SEO/GEO analyzer → Report types**, or
   `/admin/config/ai/seo/report-types`.
2. Eight ship enabled by default:
   - **full** — the full SEO analysis (also the default used by queued after-save
     analysis)
   - **topic_authority** — topical authority and depth
   - **natural_language** — readability and conversational tone
   - **link_analysis** — internal/external linking quality
   - **headings_and_structure** — heading hierarchy and structure
   - **schema_org_markup** — Schema.org / structured-data markup
   - **ai_citability** — how likely the page is to be cited by AI search (GEO)
   - **agentic_readiness** — readiness for agentic search
3. For each report type you can edit its **label**, **description**, and **prompt**,
   toggle its **status** (disable ones you don't want offered), or **Add** your own
   custom report type with a bespoke prompt.

## Running an analysis

Once configured, editors with the right permissions can:

- Click **Analyze SEO** from a node's operations/contextual links.
- Use the **AI SEO/GEO Analysis** sidebar on the node edit form to view the latest
  report, run a live streaming analysis of unsaved draft content, or tick **"Queue
  analysis after saving"** to run it in the background on cron (avoiding a slow
  request).
- If field buttons are enabled, click the **SEO/GEO ✦** button on an individual text
  field for focused advice.

View a node's saved reports at **/node/{node}/seo**.

See the [`agent/`](../agent/start.md) docs for the services, the storage table, the
queue worker, and the full route list.
