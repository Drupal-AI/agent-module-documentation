<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Groq Provider adds Groq as a low-latency LLM provider for Drupal's AI module.

---

Install it with Composer (`composer require drupal/ai_provider_groq`) and enable it; it pulls in the **AI** module and the **Key** module, and runs on Drupal core `^10.2 || ^11` (current release is **1.2.0-rc1**, a release candidate). Get an API key at `https://console.groq.com/keys`, then — because the module stores only a reference, not the secret — create a **Key** entity to hold it (ideally the Key module's environment-variable provider so the token never lands in exported configuration). Go to **Configuration → AI → Providers → Groq Configuration** (`/admin/config/ai/providers/groq`, permission *administer ai providers*), select your Key in the **Groq API Key** field, and set the default fallback request settings: **Reasoning Format** (`parsed`/`raw`/`hidden`), **Temperature** (0–2), **Max Tokens**, and **JSON Mode**. Then open the core **AI settings** and pick **Groq** as the provider for the **Chat** (and *Chat with Complex JSON*) operations plus a model such as `llama-3.3-70b-versatile`; Groq here supports the **chat** operation only, with streaming. Available models are listed live from Groq (text-to-speech and Whisper models are hidden, and only a fixed allow-list is offered when function calling is required). Once a chat operation uses Groq, the settings form grows an **Operation-Specific Settings** section where you can override the defaults per operation. Groq's draw is speed — inference on purpose-built hardware returns tokens fast enough for interactive editorial use — but treat the key as a spending credential with a provider-side limit, remember that every prompt leaves the site, and pin a specific model rather than relying on availability.

---

- Add Groq as an AI provider for the AI module.
- Enable low-latency LLM inference on a Drupal site.
- Store the Groq API key in a Key entity (env-var backed).
- Configure the Groq API key at the provider settings form.
- Set a default temperature for Groq chat requests.
- Set default max tokens for Groq responses.
- Choose a reasoning format (parsed / raw / hidden).
- Enable JSON mode for structured chat output.
- Override chat settings per AI operation.
- Select Groq for the Chat operation in AI settings.
- Select Groq for the Chat with Complex JSON operation.
- Pick a chat model such as `llama-3.3-70b-versatile`.
- Stream chat responses from Groq.
- Power an interactive editorial assistant.
- Generate inline suggestions while an editor types.
- Reformulate a search query in real time.
- Summarise content quickly with a fast model.
- Run open-weight models (Llama, Qwen, Mixtral, Gemma) via an API.
- Restrict function-calling to Groq's tool-capable models.
- Migrate configuration from the legacy in-core Groq submodule.
