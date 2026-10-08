AI Search Block Log Tag classifies logged AI-search questions into your own per-block tag vocabulary using a chat model, on cron, and charts the results.

---

This submodule of AI Search Block builds on AI Search Block Log. When a log entry receives its answer, an `entity_update` hook queues it for tagging. On cron, a queue worker (`ai_search_block_log_tag_worker`) sends the logged question plus the tag list configured for that block to a chat model — a fast, cheap model you select, or the AI module's default chat model — using a prompt template you control (tokens `[user_question]` and `[configuration_tags]`, temperature 0 for deterministic output). Only returned tags that match the configured set (case-insensitive) are written to a dedicated `ai_search_block_log_tag` table; unknown tags are discarded. Tagging is idempotent — reprocessing a log replaces its tags rather than duplicating them — and historical logs can be tagged in bulk from an admin form. A Tag Statistics dashboard charts searches per day by tag and the share across tags for the current and previous month.

---

- Automatically classify AI-search questions into meaningful tags.
- Use a different tag vocabulary per block (e.g. professional vs. consumer audiences).
- Control the classification prompt with `[user_question]` and `[configuration_tags]` tokens.
- Pick a fast, cheap model for tagging, or fall back to the default chat model.
- Restrict accepted tags to the configured set, discarding anything else the model returns.
- Run classification asynchronously on cron so searches never wait for tagging.
- Tune the cron batch size for tagging throughput.
- Re-tag historical log entries in bulk from the admin process form.
- Re-run bulk tagging safely — tags are replaced, not duplicated.
- Chart searches per day broken down by tag.
- See the distribution of searches across tags as a donut chart.
- Spot tags that never match (candidates to remove or reword).
- Clean up tags automatically when a log entry is deleted.
- Enable or disable tagging independently per block.
- Feed tag data to downstream content-gap analysis.
- Gate tagging configuration behind the "administer ai_search_block_log_tag" permission.
