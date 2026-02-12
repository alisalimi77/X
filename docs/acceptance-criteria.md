# Acceptance Criteria and Evidence Matrix

This document maps security, accessibility, API contract, and quality requirements to verifiable controls.

## Evidence convention

- Evidence artifacts are stored under `evidence/`.
- CI enforces artifact presence using `ci/check-evidence.sh ci/evidence-manifest.txt`.
- Owners are accountable roles; implementation teams can map these to named individuals.

## OWASP Top 10 (A01–A10)

| Requirement | Implementation control | Automated validation command | Evidence artifact | Owner |
|---|---|---|---|---|
| A01: Broken Access Control | Centralized authorization middleware, deny-by-default route policy, object-level access checks | `test -s evidence/security/access-control-test-report.xml` | `evidence/security/access-control-test-report.xml` | Security Engineering |
| A02: Cryptographic Failures | TLS enforced, secrets in vault, encryption at rest and in transit, approved ciphers only | `test -s evidence/security/crypto-config-audit.log` | `evidence/security/crypto-config-audit.log` | Platform Engineering |
| A03: Injection | Parameterized queries, input validation, output encoding, SAST rules for injection sinks | `test -s evidence/security/sast-injection-report.sarif` | `evidence/security/sast-injection-report.sarif` | Application Engineering |
| A04: Insecure Design | Threat modeling in design reviews, abuse-case driven tests, architecture decision records | `test -s evidence/security/threat-model-review.md` | `evidence/security/threat-model-review.md` | Architecture |
| A05: Security Misconfiguration | Hardened baselines, IaC policy checks, secure headers, unnecessary services disabled | `test -s evidence/security/configuration-baseline-scan.json` | `evidence/security/configuration-baseline-scan.json` | DevOps |
| A06: Vulnerable and Outdated Components | Dependency pinning, CVE scanning, patch SLAs | `test -s evidence/security/dependency-audit-report.sarif` | `evidence/security/dependency-audit-report.sarif` | Security Engineering |
| A07: Identification and Authentication Failures | MFA for privileged access, session timeout/rotation, secure password policy | `test -s evidence/security/authentication-controls-report.log` | `evidence/security/authentication-controls-report.log` | Identity Team |
| A08: Software and Data Integrity Failures | Signed builds, provenance/SBOM, protected artifact registry, integrity checks | `test -s evidence/security/supply-chain-integrity-report.json` | `evidence/security/supply-chain-integrity-report.json` | Release Engineering |
| A09: Security Logging and Monitoring Failures | Structured audit logging, SIEM forwarding, alert playbooks and coverage checks | `test -s evidence/security/logging-monitoring-coverage.md` | `evidence/security/logging-monitoring-coverage.md` | SRE |
| A10: SSRF | Egress restrictions, URL allowlists, metadata endpoint blocking, SSRF tests | `test -s evidence/security/ssrf-test-report.log` | `evidence/security/ssrf-test-report.log` | Platform Engineering |

## WCAG 2.1 AA

| Requirement | Implementation control | Automated validation command | Evidence artifact | Owner |
|---|---|---|---|---|
| WCAG 2.1 AA conformance baseline | Semantic HTML, keyboard navigation support, contrast compliance, alt text standards | `test -s evidence/accessibility/wcag-aa-axe-report.json` | `evidence/accessibility/wcag-aa-axe-report.json` | UX Engineering |
| Keyboard operability | Focus order management, visible focus indicators, no keyboard traps | `test -s evidence/accessibility/keyboard-navigation-checklist.md` | `evidence/accessibility/keyboard-navigation-checklist.md` | Frontend Engineering |
| Screen reader compatibility | Landmark roles, labels, ARIA usage review, announcement testing | `test -s evidence/accessibility/screen-reader-test-notes.md` | `evidence/accessibility/screen-reader-test-notes.md` | UX Engineering |
| Color and contrast | Design token contrast thresholds, automated contrast checks | `test -s evidence/accessibility/color-contrast-report.json` | `evidence/accessibility/color-contrast-report.json` | Design Systems |

## OpenAPI 3.1

| Requirement | Implementation control | Automated validation command | Evidence artifact | Owner |
|---|---|---|---|---|
| OpenAPI schema valid against 3.1 | API definitions authored in OpenAPI 3.1, schema linting in CI | `test -s evidence/api/openapi-3.1-validation.log` | `evidence/api/openapi-3.1-validation.log` | API Platform |
| Contract completeness | Required response codes, examples, auth schemes, error objects defined | `test -s evidence/api/openapi-lint-report.sarif` | `evidence/api/openapi-lint-report.sarif` | API Platform |
| Backward compatibility checks | Versioning policy and contract diff checks before merge | `test -s evidence/api/openapi-compatibility-report.md` | `evidence/api/openapi-compatibility-report.md` | API Platform |

## ISO 25010 Quality Attributes

| Attribute | Implementation control | Automated validation command | Evidence artifact | Owner |
|---|---|---|---|---|
| Functional suitability | Requirements-to-test traceability and acceptance tests | `test -s evidence/quality/functional-suitability-traceability.csv` | `evidence/quality/functional-suitability-traceability.csv` | QA |
| Performance efficiency | Performance budgets and load/stress testing | `test -s evidence/quality/performance-benchmark-report.json` | `evidence/quality/performance-benchmark-report.json` | Performance Engineering |
| Compatibility | Cross-browser/integration environment matrix testing | `test -s evidence/quality/compatibility-matrix-report.md` | `evidence/quality/compatibility-matrix-report.md` | QA |
| Usability | Usability test protocol and issue closure workflow | `test -s evidence/quality/usability-evaluation-summary.md` | `evidence/quality/usability-evaluation-summary.md` | UX Research |
| Reliability | Error budget tracking, resilience tests, backup/restore drills | `test -s evidence/quality/reliability-test-report.log` | `evidence/quality/reliability-test-report.log` | SRE |
| Security | Security controls aligned to OWASP and hardening baseline | `test -s evidence/security/security-control-summary.md` | `evidence/security/security-control-summary.md` | Security Engineering |
| Maintainability | Code quality gates, static analysis, test coverage threshold | `test -s evidence/quality/maintainability-static-analysis.sarif` | `evidence/quality/maintainability-static-analysis.sarif` | Application Engineering |
| Portability | Build/deploy portability and environment parity checks | `test -s evidence/quality/portability-deployment-report.md` | `evidence/quality/portability-deployment-report.md` | DevOps |

## CI gate policy

A merge is blocked when any required evidence artifact is missing or empty.

Core gating command:

```bash
ci/check-evidence.sh ci/evidence-manifest.txt
```

This command is executed in CI and exits non-zero when an artifact is absent.
