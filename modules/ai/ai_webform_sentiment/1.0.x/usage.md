Runs AI sentiment analysis on webform submissions, storing a numeric score per submission and charting the trend on a per-webform results tab.

---

AI Webform Sentiment ships a Webform handler plugin (`sentiment_analysis`) that you attach to any webform. When a visitor submits (drafts are skipped), the handler enqueues the submission into the `analyze_sentiment` queue. On the next cron run, a queue worker hands each item to the `SentimentProcessor` service, which builds a prompt (substituting the submission's field data into a `[submission]` placeholder), calls the configured Large Language Model through the AI module's chat operation, casts the model's reply to an integer, and writes it to the dedicated `ai_webform_sentiment` database table. A "Sentiment" tab on the webform's Results page (`/admin/structure/webform/manage/{webform}/results/sentiment`) then renders the last month of scores as average, daily-trend, and distribution charts using Chart.js (provided by the `chartjs_api` module). The scoring scale is defined entirely by the editable prompt, so you can ask for 0-5, 1-10, or any numeric range. Cron must be running, and each submission incurs one LLM call (and therefore potential cost). The module is marked experimental and its author warns the dashboard queries are not load-tested for large result sets.

---

- Score contact-form submissions from 0 (very negative) to 5 (very positive) automatically on each cron run.
- Track the average customer sentiment of a feedback webform over the last month.
- Visualise the daily sentiment trend of survey responses as a line chart on the webform results page.
- See the distribution (counts) of each sentiment value for a webform in a bar chart.
- Attach sentiment scoring to multiple webforms independently, each with its own prompt and model.
- Choose a specific LLM per webform (e.g. a cheaper model for high-volume forms) or fall back to the AI module's default chat provider.
- Change scoring granularity by editing the prompt — e.g. score 1-10 instead of 0-5.
- Ask the model for a coarse positive/negative split (0 or 1) by rewriting the prompt.
- Prioritise which support tickets (submitted via webform) to answer first by low sentiment score.
- Monitor whether a marketing campaign's inbound form responses trend more positive over time.
- Flag event-registration feedback that scores below a threshold for manual follow-up.
- Provide site editors a no-code AI sentiment dashboard without writing custom code.
- Backfill sentiment for a backlog of queued submissions on demand with `drush ai_webform_sentiment:process-queue` (alias `aisq`) instead of waiting for cron.
- Restrict who can view the sentiment dashboard using the webform "access webform results" permission.
- Restrict who can reach the module settings page with the "administer ai webform sentiment" permission.
- Combine several open-ended webform fields into one sentiment score (all submission fields are concatenated into the prompt).
- Compare sentiment across product-feedback forms by reading each webform's own Sentiment tab.
- Run the analysis asynchronously so form submitters never wait on the LLM (all work happens on cron via a queue).
- Tune model creativity per handler via the `llm_temp` configuration value passed to the provider.
- Use it as a starting template for other per-submission AI post-processing (queue + cron + handler pattern).
