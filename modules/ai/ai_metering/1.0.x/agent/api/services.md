# Services

| Service id | Interface/class | Use |
|---|---|---|
| `ai_metering.quota_manager` | `Service\QuotaManager` | Get/set quotas, `logUsage()`, alerts. |
| `ai_metering.token_estimator` | `Service\TokenEstimator` | Pre-flight token + cost estimate for a prompt. |
| `ai_metering.model_pricing` | `Service\ModelPricingService` | Per-model prices (uses PricingSource plugins). |
| `ai_metering.cost_reporter` | `Service\CostReporter` | Aggregate/report usage from the DB. |
| `ai_metering.exchange_rate` | `Service\ExchangeRateService` | Live currency conversion (Frankfurter). |
| `ai_metering.alert` | `Service\AlertService` | Email quota alerts. |
| `ai_metering.litellm_proxy` | `Service\LiteLLMProxyService` | LiteLLM proxy integration. |
| `ai_metering.token_count_dispatcher` | — | Routes to provider-native counters (`…token_counting.anthropic`, `…token_counting.ollama`). |
| `ai_metering.pre_generate_subscriber` / `ai_metering.post_generate_subscriber` | EventSubscriber | Enforce quota pre-call; log tokens/cost post-call. |

```php
// Estimate before an expensive call:
$est = \Drupal::service('ai_metering.token_estimator')->estimate($prompt, $model_id);

// Aggregate cost for reporting:
$report = \Drupal::service('ai_metering.cost_reporter')->…;
```
Metering itself is automatic — the two event subscribers hook `ai` core's
Pre/PostGenerateResponse events, so you do not call `logUsage()` yourself for normal
provider calls. A `MeteringRecordCreatedEvent` is dispatched after each record is written.
