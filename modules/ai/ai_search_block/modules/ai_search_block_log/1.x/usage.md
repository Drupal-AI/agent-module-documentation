AI Search Block Log stores every AI Search Block question, answer, prompt and source set as a log entity, lets visitors rate and comment on answers, and gives admins analytics dashboards.

---

This submodule of AI Search Block adds an `ai_search_block_log` content entity that captures each search interaction: the question, the response given, the prompt used, a JSON `detailed_output` of the sources, the acting user, a block id, and created/expiry timestamps. The parent module opens a log row when a query starts and fills in the response and prompt when the answer completes. Visitors can score an answer (thumbs up/down) and submit free-text feedback, which posts to `/ai-search-block-log/score` and is saved on the row. Admins configure a retention period and browse a suite of dashboards at `/admin/config/ai/ai_search_block_log`: an overview, per-day/per-block/per-user search charts, scoring statistics, and an "AI analysis" page where the default chat model summarises recurring themes in low-rated searches and feedback. A cron hook prunes log rows older than the retention window.

---

- Keep an auditable record of every AI search question and the answer returned.
- Store the exact prompt sent to the model for each answer (debugging and review).
- Store a JSON snapshot of the source items used to build each answer.
- Attribute each search to the acting user (or anonymous) and a block id.
- Let visitors rate answers with a thumbs score.
- Collect free-text visitor feedback on poor answers.
- Configure a retention period (day/week/month/year) for log rows.
- Automatically delete expired log rows on cron.
- View a graphs overview with key monthly metrics and scoring stats.
- Chart total searches per day across the retention window.
- Chart searches broken down per block and per user.
- Chart score distribution over time and average score per day.
- See scoring statistics: total vs. scored submissions, poor/good percentages.
- Generate an AI summary of recurring themes in low-rated searches and feedback.
- Browse, edit and delete individual log entries through the entity admin UI.
- Bulk-delete log entries via the entity collection listing.
- Gate all log administration behind the "administer ai_search_block_log" permission.
- Feed logged questions to the tagging submodule for AI classification.
- Review which blocks and users generate the most search volume.
- Spot content gaps by reviewing questions that scored poorly.
