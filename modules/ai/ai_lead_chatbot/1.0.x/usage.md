AI Lead Chatbot adds an OpenAI-backed chat widget that converses with visitors and stores captured leads as `chatbot_lead` entities.

---

AI Lead Chatbot places a floating chat widget on the site that talks to visitors through OpenAI's chat-completions API. During the conversation the assistant works to extract three details — the service the visitor is interested in, their name, and a phone or email contact — and once all three are collected it saves them as a `chatbot_lead` content entity that staff review under Content → Chatbot Leads. Per-session conversation state lives in Drupal's private tempstore. Administrators set the business name, chatbot tone, an FAQ knowledge base, and OpenAI model/temperature/max-tokens at Configuration → Services → AI Lead Chatbot; the OpenAI API key is read from `settings.php`. The widget can be auto-attached to all non-admin pages or placed manually via the "AI Lead Chatbot Widget" block, and because leads are Drupal entities they work with Views for reporting and export. The module depends only on core `system` and `user` and targets Drupal 11.

---

- Add an AI chat widget to a public Drupal site for lead capture.
- Qualify visitors through a natural conversation instead of a static contact form.
- Extract a visitor's service interest, name, and contact from chat automatically.
- Store completed leads as `chatbot_lead` content entities.
- Review captured leads in the admin list at `/admin/content/ai-chatbot-leads`.
- Build custom Views reports and exports over the lead entity.
- Configure the chatbot's business name and conversational tone (friendly, professional, casual, formal).
- Give the bot an FAQ knowledge base (`Question? | Answer` per line) it can answer from mid-conversation.
- Choose the OpenAI model (e.g. `gpt-4o-mini`, `gpt-4`) per site.
- Tune response creativity and length with temperature and max-tokens settings.
- Auto-display the floating widget on all non-admin pages with one checkbox.
- Place the widget deliberately on selected pages via the "AI Lead Chatbot Widget" block.
- Keep the OpenAI API key out of config by reading it from `settings.php`.
- Provide 24/7 first-line visitor engagement without live-chat staff.
- Answer common pre-sales questions while still collecting contact details.
- Power a headless/decoupled front end via the JSON `/chat/start` and `/chat` endpoints.
- Support service businesses (agencies, consulting, legal, trades) capturing enquiries.
- Qualify SaaS trial or demo requests before they reach sales.
- Capture event or admissions enquiries conversationally.
- Track which service each lead asked about for routing to the right team.
- Grant marketing/sales staff read access to leads separately from edit/delete rights.
