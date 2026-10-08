AI CKEditor WCAG adds a CKEditor 5 action that prompts AI to check the selected text for WCAG compatibility.

---

AI CKEditor WCAG adds one AI CKEditor action plugin, "WCAG", that lets editors ask an AI model whether the text they selected in CKEditor 5 conforms to a chosen WCAG (Web Content Accessibility Guidelines) version and level. It plugs into the ai_ckeditor dialog: the editor selects text, opens the AI Assistant, picks WCAG, and clicks "Check the selected text"; the AI feedback streams back into a response field in the editor dialog and is returned in the same language as the text. The target WCAG version (1.0, 2.0, 2.1, 2.2) and conformance level (A, AA, AAA) are configured per text format, as is the AI provider/model (or the AI module chat default). Checks run through the drupal/ai chat provider and incur provider cost. Requires core ckeditor5, the AI module, and its ai_ckeditor submodule; supports Drupal 10.3+ and 11. It is an advisory aid, not an automated fixer or a full accessibility audit.

---

- Ask AI whether a selected passage meets WCAG 2.1 AA.
- Get plain-language accessibility feedback while editing.
- Check heading structure and link-text wording for a11y issues.
- Review a paragraph against WCAG 2.2 AAA before publishing.
- Give content authors an in-editor accessibility helper.
- Spot missing context in link text ("click here").
- Get suggestions to improve reading clarity for accessibility.
- Choose which WCAG version to check against per text format.
- Choose the conformance level (A/AA/AAA) to target.
- Pick a specific AI provider/model for accessibility checks.
- Return feedback in the author's own language.
- Add an accessibility review step to editorial workflow.
- Educate authors on WCAG rules as they write.
- Sanity-check content structure without leaving CKEditor.
- Flag potential contrast or semantic-markup concerns for follow-up.
- Complement (not replace) automated a11y scanners.
- Encourage accessible writing habits across contributors.
- Review call-to-action wording for clarity.
- Check list and table usage described in the selected text.
- Prompt AI feedback on demand for any selected block.
