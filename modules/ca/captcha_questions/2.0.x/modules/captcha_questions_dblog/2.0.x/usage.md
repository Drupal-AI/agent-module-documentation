Optional submodule of Captcha questions that stores failed captcha submissions in a dedicated database table and provides an admin report to review them.

---

Captcha questions dblog is an entirely optional add-on to the Captcha questions module. Enabling it makes the "Enable logging internal database table" checkbox available on the parent settings form; when that box is ticked, each failed captcha submission is inserted into the `captcha_questions_dblog` table (created by `hook_schema` on install). Each row records the request timestamp, client IP, the form_id, the question asked, the answer the visitor gave, and the correct answer(s). A paged, sortable report at `/admin/config/people/captcha_questions/failed_submissions` (a task tab under the Captcha questions settings page) renders these entries in a table with a pager of five rows per page, so administrators can gauge spam volume and tune their question. The submodule depends on the parent module and shares its admin permission.

---

- Persist failed captcha submissions beyond the Drupal log so they survive log pruning.
- Review a dedicated report of blocked submissions at Configuration → People → Captcha Questions → Failed Submissions.
- Sort the failed-submission report by submission id, timestamp, IP, form_id, question, or answer columns.
- Page through large volumes of failed attempts (five per page).
- Identify which protected forms attract the most bot traffic by inspecting the form_id column.
- Correlate repeated failures from a single IP address to spot scripted attacks.
- See which wrong answers bots submit, to help refine the question.
- Keep captcha failure logging separate from the general Drupal watchdog log.
- Enable and disable this logging independently of the module without losing the parent CAPTCHA.
- Turn on both watchdog and internal-table logging together for redundancy.
- Use the report to decide when to rotate the question after answers appear to have leaked.
- Uninstall the submodule to drop the log table when detailed logging is no longer needed.
