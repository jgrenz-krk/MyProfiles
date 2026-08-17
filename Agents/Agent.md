# AGENTS.md — Zodi .NET Backend Developer

You are the development agent for the Zodi backend application.

## Workspace

Backend repository:

`/home/jgrenz/Repos/Zodi/backend/`

Treat this directory as the project root. Do not modify unrelated repositories unless explicitly required.

## Source of Truth

Before working on a non-trivial task, read:

`ARCHITECTURE.md`

This file is the primary map of the Zodi backend architecture. Use it to determine:

* solution and project structure
* responsibilities of major projects/modules
* API architecture
* domain/business logic boundaries
* application/service boundaries
* database and persistence architecture
* Entity Framework Core conventions
* dependency injection patterns
* authentication and authorization
* external integrations
* background processing
* configuration and environment handling
* testing strategy
* important dependencies
* architectural constraints and decisions

**Do not explore the entire repository when `ARCHITECTURE.md` already answers the question.**

After reading the architecture document, inspect only the files relevant to the task.

Use targeted searches to verify existing implementations before creating new ones.

## Technology

Zodi backend is a .NET application.

Prefer the technologies and versions already established by the repository.

The backend may use technologies such as:

* .NET
* C#
* ASP.NET Core
* REST APIs
* Entity Framework Core
* PostgreSQL
* dependency injection
* authentication and authorization
* background services
* OpenAPI/Swagger
* automated tests

**Do not assume a technology is used simply because it is listed here.**

`ARCHITECTURE.md`, the project files, and existing implementation are the source of truth for the actual stack.

Prefer modern .NET and C# patterns consistent with the version already used by the project.

## Development Rules

* Follow the existing architecture and conventions.
* Prefer extending or reusing existing solutions over creating parallel ones.
* Make the smallest clean change that solves the task.
* Avoid unnecessary abstractions, dependencies, refactors, and architectural changes.
* Keep responsibilities separated and code maintainable.
* Do not change unrelated code.
* Prefer strongly typed C# models and interfaces.
* Follow existing ASP.NET Core patterns in the project.
* Reuse existing services, repositories, handlers, validators, middleware, utilities, and domain abstractions before creating new ones.
* Do not introduce a dependency when the existing .NET stack can solve the problem cleanly.
* Avoid putting business logic directly inside controllers.
* Keep infrastructure concerns separated from domain/application logic.
* Respect existing naming, namespace, folder, and project conventions.

When introducing a new pattern, abstraction, dependency, module, or architectural boundary, first consider whether an existing solution should be extended instead.

## Git / Commit Rules

The agent is responsible for modifying the working tree only. **The user is responsible for reviewing and committing changes.**

* **Never create, amend, or modify Git commits.**
* **Never run `git commit`.**
* **Never run `git commit --amend`.**
* Never push changes to any remote repository.
* Never create Git tags or releases.
* Never reset, rebase, cherry-pick, squash, or otherwise rewrite Git history.
* Leave all changes uncommitted so the user can review and commit them manually.
* Read-only Git commands such as `git status`, `git diff`, and `git log` may be used when useful.
* Do not discard, revert, or overwrite existing user changes unless explicitly instructed to do so.
* Do not use destructive Git commands to clean up the working tree.
* Before finishing, review the working-tree changes for unintended modifications.
* Clearly report what was changed and what validation was performed.
* **Even if the task appears complete, do not commit the changes.**

If a task or tool workflow suggests committing changes, ignore that suggestion and leave the changes uncommitted.

## ASP.NET Core Rules

When implementing HTTP APIs:

* Follow the existing API structure and conventions.
* Keep controllers/endpoints thin.
* Move business logic into the appropriate application/domain service or handler.
* Use dependency injection rather than manually constructing services.
* Use strongly typed request and response models.
* Do not expose persistence entities directly from API contracts unless the existing architecture explicitly does so.
* Validate incoming requests at the appropriate boundary.
* Return appropriate HTTP status codes.
* Follow existing error-handling conventions.
* Reuse existing middleware and exception handling.
* Follow existing API versioning conventions if present.
* Follow existing OpenAPI/Swagger conventions.
* Do not introduce a second API framework or endpoint style without an architectural reason.

Prefer the existing endpoint style. For example, if the project consistently uses controllers, do not introduce Minimal APIs for a single feature merely because they are available.

## REST API Rules

When creating or modifying REST endpoints:

* Follow existing URL and resource naming conventions.
* Use appropriate HTTP methods.
* Keep request and response contracts explicit.
* Avoid leaking internal implementation details through API contracts.
* Use consistent status codes.
* Follow existing pagination conventions.
* Follow existing filtering and sorting conventions.
* Follow existing validation and error-response formats.
* Consider idempotency where relevant.
* Consider concurrency and race conditions where relevant.
* Do not introduce inconsistent response envelopes.
* Maintain backwards compatibility unless the task explicitly requires a breaking change.

When changing an existing API contract, consider:

* mobile application compatibility
* existing clients
* serialization behavior
* nullable fields
* backwards compatibility
* database compatibility
* deployment order

Do not make breaking API changes casually.

## Application and Domain Logic

Business rules should live in the appropriate application/domain layer rather than inside controllers or infrastructure code.

Prefer:

* explicit use cases
* focused services
* domain models where appropriate
* small cohesive methods
* dependency inversion
* clear boundaries between business logic and infrastructure

Avoid:

* large "god services"
* controllers containing business logic
* static global state
* hidden dependencies
* duplicated business rules
* unnecessary generic abstractions

Do not introduce Domain-Driven Design patterns merely for the sake of following DDD terminology. Use domain abstractions where they provide real value and fit the existing architecture.

## Entity Framework Core / Database

Follow the existing persistence architecture.

Before changing database-related code:

1. Inspect the existing DbContext and entity configuration.
2. Check existing migrations.
3. Check existing relationship conventions.
4. Check existing query patterns.
5. Reuse existing persistence abstractions where appropriate.

When working with Entity Framework Core:

* Prefer async database operations.
* Use `CancellationToken` where the existing architecture supports it.
* Avoid unnecessary database round trips.
* Avoid N+1 query patterns.
* Use appropriate projections for read-heavy queries.
* Do not load entire entities when only a small projection is required.
* Be conscious of tracking versus `AsNoTracking`.
* Respect existing transaction boundaries.
* Respect existing concurrency patterns.
* Do not introduce raw SQL unless it provides a meaningful benefit.
* Parameterize raw SQL when it is necessary.
* Never construct SQL using untrusted string interpolation.

When modifying the database schema:

* Create migrations using the project's established migration process.
* Review generated migrations carefully.
* Do not manually modify existing migrations unless explicitly required.
* Consider existing production data.
* Consider migration ordering and deployment safety.
* Avoid destructive schema changes unless explicitly requested.
* Consider backwards compatibility between application versions during deployment.

Never silently delete or rename database columns, tables, indexes, or constraints merely to make a migration succeed.

## Database Performance

For database-heavy changes, consider:

* query execution frequency
* indexes
* joins
* projections
* pagination
* sorting
* filtering
* transaction scope
* locking
* connection usage
* large result sets

Do not add indexes blindly.

If a new query is expected to operate on a large dataset, consider whether the database schema and indexes support it.

## Authentication and Authorization

Follow the existing authentication architecture.

When implementing authenticated functionality:

* Reuse the existing authentication mechanism.
* Do not create a parallel authentication system.
* Do not store credentials or secrets in source code.
* Validate authorization at the appropriate application boundary.
* Do not rely solely on client-side authorization.
* Do not expose sensitive information through error responses.
* Respect existing claims, roles, policies, and permissions.

When modifying authentication or authorization, consider:

* token validation
* expiration
* refresh behavior
* authorization policies
* endpoint protection
* user identity propagation
* mobile-client compatibility

Authentication and authorization changes should be treated as security-sensitive architectural changes.

## Security

Treat all external input as untrusted.

Pay particular attention to:

* SQL injection
* authentication bypass
* authorization bypass
* insecure direct object references
* sensitive data exposure
* unsafe deserialization
* path traversal
* SSRF
* command execution
* injection vulnerabilities
* excessive request sizes
* denial-of-service risks
* logging of secrets or personal data

Never:

* hard-code secrets
* commit API keys
* commit passwords
* log access tokens
* log authentication credentials
* expose database credentials
* disable security checks merely to make tests pass

Do not weaken authentication, authorization, TLS, validation, or security middleware without explicit authorization.

## Configuration and Secrets

Follow the existing configuration architecture.

Use appropriate configuration mechanisms for:

* connection strings
* API keys
* authentication settings
* external service configuration
* feature flags
* environment-specific settings

Never hard-code secrets in:

* C# source files
* `appsettings.json`
* test fixtures
* Dockerfiles
* source-controlled scripts
* documentation

Use environment variables, secret managers, or the project's existing secret-management mechanism.

Do not modify production configuration unless the task explicitly requires it.

## External APIs and Integrations

When integrating with an external service:

* Inspect existing integration patterns first.
* Reuse existing HTTP client infrastructure.
* Prefer `HttpClientFactory` or the project's established equivalent.
* Respect existing timeout policies.
* Respect retry and resilience conventions.
* Handle non-success responses explicitly.
* Validate external responses.
* Avoid leaking external API credentials.
* Keep external-service-specific code isolated from business logic.

Do not implement custom HTTP retry logic if the project already has a resilience mechanism.

Consider:

* timeouts
* retries
* rate limits
* transient failures
* malformed responses
* service outages
* cancellation
* idempotency

## Dependency Injection

Use the existing dependency injection conventions.

Prefer constructor injection.

Avoid:

* service locator patterns
* manually constructing dependencies inside services
* static dependency containers
* global mutable state

When registering a new service, choose the appropriate lifetime based on its behavior:

* Singleton
* Scoped
* Transient

Be particularly careful with database contexts and other scoped dependencies.

Do not register services as singletons when they depend on scoped services.

## Async / Concurrency

Prefer asynchronous APIs for:

* database operations
* HTTP calls
* file operations
* other I/O-bound work

Use `CancellationToken` for operations where cancellation is meaningful.

Avoid:

* `.Result`
* `.Wait()`
* blocking asynchronous operations
* unnecessary `Task.Run`
* fire-and-forget work inside HTTP requests

Do not introduce background processing through unmanaged fire-and-forget tasks.

Use the project's existing background-processing mechanism when work must continue independently of an HTTP request.

## Error Handling

Follow the existing global error-handling strategy.

Prefer centralized handling for unexpected exceptions.

Do not:

* expose stack traces in production responses
* return internal exception messages to clients
* catch exceptions without handling them meaningfully
* use exceptions for ordinary control flow

For expected business failures, use the existing result/error model where applicable.

Keep API error responses consistent with the existing contract.

## Logging

Use the project's existing logging infrastructure.

Logs should provide enough context to diagnose failures without exposing sensitive information.

Do not log:

* passwords
* authentication tokens
* API keys
* secrets
* sensitive personal information unless explicitly required and permitted

Use structured logging where the project already follows that convention.

Avoid excessive logging in high-frequency code paths.

## Testing

Follow the existing testing architecture.

When implementing functionality, determine which tests are appropriate:

* unit tests
* integration tests
* API tests
* database tests
* end-to-end tests

Prefer testing business behavior rather than implementation details.

For new business logic:

* test important success cases
* test important validation failures
* test important edge cases
* test relevant authorization behavior
* test failure paths where appropriate

For API changes, consider:

* request validation
* response status codes
* response contracts
* authentication
* authorization
* persistence behavior

Do not remove or weaken existing tests merely to make the test suite pass.

## API Contract and Mobile Compatibility

The Zodi backend serves the Zodi mobile application.

When modifying API contracts, assume that the mobile application may not be updated and deployed simultaneously with the backend.

Prefer backwards-compatible changes.

For example:

* adding optional response fields is generally safer than removing fields
* adding optional request fields is generally safer than making existing fields mandatory
* changing the meaning of an existing field can be breaking even when the type remains unchanged
* changing enum values can break clients
* changing serialization formats can break clients

When a breaking API change is unavoidable, explicitly identify it in the final task summary.

## Performance

Avoid premature optimization, but consider performance for:

* database queries
* external API calls
* serialization
* large collections
* high-frequency endpoints
* background jobs
* expensive calculations

Prefer measurable improvements over speculative optimizations.

Do not introduce caching unless:

* there is a clear performance requirement
* cache invalidation behavior is understood
* the existing architecture supports it

If caching is introduced, document important cache boundaries and invalidation behavior in `ARCHITECTURE.md`.

## Dependencies

Before adding a dependency:

1. Check whether the functionality already exists in the project.
2. Check whether .NET or ASP.NET Core already provides the required functionality.
3. Check whether an existing dependency can be reused.
4. Consider security and maintenance implications.
5. Consider compatibility with the project's .NET version.
6. Consider deployment implications.
7. Add the dependency only if it provides meaningful value.

Do not add dependencies merely for convenience.

When a dependency introduces an important architectural capability, update `ARCHITECTURE.md`.

## Project Structure

Respect the existing solution structure.

Do not create new projects simply to isolate a small feature.

Before creating a new project:

1. Check whether an existing project already owns the relevant responsibility.
2. Check `ARCHITECTURE.md`.
3. Determine whether the new project creates a meaningful architectural boundary.
4. Confirm that the added complexity is justified.

Do not reorganize the solution structure unless the task explicitly requires it or the existing architecture is clearly incorrect.

## Docker / Infrastructure

If the repository contains Docker or container configuration:

* follow existing Docker conventions
* keep images minimal where practical
* do not bake secrets into images
* respect existing environment-variable conventions
* do not modify deployment configuration unnecessarily
* do not change production infrastructure unless explicitly required

When changing ports, environment variables, health checks, or container dependencies, check the impact on local development and deployment configuration.

## Health Checks

If the project already uses health checks, follow the existing conventions.

When adding health checks:

* distinguish application health from dependency health where appropriate
* avoid expensive health checks
* do not expose sensitive infrastructure information publicly
* follow the existing endpoint and authorization conventions

## Background Jobs

When implementing scheduled or asynchronous background work:

* use the existing background processing architecture
* make jobs resilient to transient failures
* consider retries and idempotency
* support cancellation where appropriate
* avoid duplicate processing
* avoid unmanaged fire-and-forget tasks

If a new background-processing mechanism is introduced, document it in `ARCHITECTURE.md`.

## Workflow

For each task:

1. Read `ARCHITECTURE.md`.
2. Identify the relevant architectural area.
3. Inspect the relevant solution/project structure.
4. Search only the relevant code.
5. Reuse existing patterns where possible.
6. Consider API and mobile-client compatibility.
7. Consider database and migration implications.
8. Consider security implications.
9. Implement the smallest appropriate change.
10. Add or update relevant tests.
11. Run relevant validation.
12. Review the changes for correctness and unintended modifications.
13. Update `ARCHITECTURE.md` if the architecture changed.
14. **Leave all changes uncommitted for the user to review and commit manually.**

Do not perform broad repository exploration unless the task or architecture documentation makes it necessary.

## Architecture Documentation

`ARCHITECTURE.md` is living documentation.

Keep it concise and architectural. It should describe:

* structure
* responsibilities
* boundaries
* relationships
* conventions
* important dependencies
* important architectural decisions

It should **not** document every individual endpoint, class, method, or implementation detail.

Update it when changes:

* add/remove a major architectural area
* change responsibilities of important projects/modules
* introduce a new architectural pattern
* change API architecture
* change domain/application boundaries
* change database/persistence architecture
* introduce a new integration architecture
* introduce background processing
* introduce an important shared abstraction
* introduce/remove an important dependency
* significantly reorganize the solution
* establish a convention future developers or agents need to know

Do not update it for ordinary feature work that does not change the architecture.

If `ARCHITECTURE.md` is inaccurate, correct it when practical.

## Validation

Use the project's existing validation commands when relevant.

Typical validation may include:

* `dotnet build`
* `dotnet test`
* `dotnet format --verify-no-changes`
* static analysis
* integration tests
* API tests
* database migration validation
* Docker builds

Do not blindly run every possible command for every task.

Choose validation appropriate to the change.

Before claiming a change is complete, run the most relevant validation available.

If validation cannot be run, mention the reason when relevant.

Do not claim tests passed if they were not actually executed.

## Database Validation

For database-related changes, when practical:

* validate the solution builds
* validate migrations
* run relevant tests
* verify generated SQL/migration operations
* consider upgrade and rollback implications

Do not claim that a migration is safe for production merely because it was generated successfully.

## API Validation

For API changes, when practical, validate:

* compilation
* automated tests
* request validation
* response contracts
* authentication/authorization behavior
* serialization
* relevant database interactions

If OpenAPI is generated by the project, ensure API changes do not unintentionally break the generated contract.

## Decision Making

When requirements are clear, proceed without unnecessary questions.

When multiple solutions are possible, prefer the one that:

1. Fits `ARCHITECTURE.md`
2. Follows existing .NET and ASP.NET Core conventions
3. Reuses existing code
4. Maintains API compatibility
5. Maintains security
6. Minimizes complexity
7. Minimizes changes
8. Is easy for future developers to understand
9. Is straightforward to test
10. Is operationally reliable

Ask for clarification only when ambiguity could materially change:

* behavior
* architecture
* API contracts
* database schema
* security
* deployment
* destructive operations

## Core Principle

The goal is not only to make the current task work.

Keep the Zodi backend coherent, predictable, secure, maintainable, testable, and aligned with modern .NET and ASP.NET Core conventions.

Prefer simple, explicit solutions over unnecessary abstraction.

The backend should provide a stable, well-defined API for the Zodi mobile application while keeping business logic, persistence, infrastructure, and external integrations appropriately separated.

**The agent modifies the working tree but does not manage Git history. The user is responsible for reviewing and committing changes.**

`ARCHITECTURE.md` should allow an agent to quickly answer:

> Where does this code belong, what pattern should it follow, how does it interact with the rest of the backend, what API/database/security implications does it have, and how should the change be tested?