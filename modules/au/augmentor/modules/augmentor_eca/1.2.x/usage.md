Augmentor ECA Rules adds an ECA action that runs a configured Augmentor over a token value and stores the response back into another token, so AI augmentation can be scripted inside ECA (BPMN/business-rules) models.

---

This submodule bridges Augmentor and the ECA module. It ships a single configurable ECA action, "Basic Augment Action" (`augmentator_eca_basic`, in `AugmentorBasic` extending `AugmentorBase`), that lets a no-code ECA model call any augmentor as a step in a workflow. The action is configured with an augmentor to run, a token holding the input text, a response key to extract from the augmentor's result, and a token name to write the result into. At runtime it reads the input token via ECA's token service, executes the augmentor, and adds the chosen response (or the whole result array when no key is set) into the result token for use by later steps. It requires both `augmentor` and `eca` (>= 2.1) and provides no routes, permissions, or config schema of its own — all gating and orchestration come from ECA.

---

- Summarise a node's body with an AI augmentor as one step inside an ECA model, then store the summary in a token.
- Translate incoming text through a translation augmentor mid-workflow and reuse the result downstream.
- Classify or tag user-submitted content via an augmentor and branch the ECA model on the returned label.
- Generate a meta description token from an article body during an ECA "on entity presave" reaction.
- Chain multiple augment steps: feed one augmentor's result token as the input token of the next.
- Extract a specific response key (e.g. `default`) from a multi-key augmentor response into a token.
- Capture the full augmentor result array into a token when you need every response key (leave the response key blank).
- Run an augmentor from any ECA event (cron, entity CRUD, custom events) without writing PHP.
- Populate a field later in the model by first augmenting text into a token, then using ECA's "set field value".
- Pre-process or normalise text via a lightweight augmentor before handing it to a heavier AI step.
- Moderate/score comments through an augmentor and store the score token for a conditional publish/unpublish.
- Build editorial automations (auto-taxonomy, auto-alt-text) as reusable ECA models instead of per-field widget config.
- Use token references in the input/result fields so the action composes cleanly with other ECA token producers.
- Drive an augmentor from a webform-submission ECA reaction to enrich the submission data.
- Keep AI orchestration in ECA's visual modeller so non-developers can adjust which augmentor runs where.
