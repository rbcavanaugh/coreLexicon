
## Core Lexicon Web-App

Core Lexicon Analysis is a discourse assessment originally developed by
Dalton & Richardson (2015) that measures the typicality of words used in
a semi-structured discourse task. This web-app is intended to facilitate
efficient and accurate core lexicon scoring for both research and
clinical practice.

## Feedback

At this stage, we would appreciate feedback on the app - whether related
to bugs/issues with the app or requested features. Please provide
feedback or report bugs using the issues tab in the github repository.

## Installation

Detailed installed instructions can be found here: https://github.com/rbcavanaugh/coreLexicon/wiki


## About Core Lexicon Analysis

CoreLex checklists have been developed for a variety of widely used
discourse tasks (including picture description, picture sequence, story
retell, procedures, and unfamiliar narrative production) have been
developed using large samples of healthy control speakers (Dalton et
al., 2020). CoreLex is a micro-linguistic measure which provides
information about word retrieval and lexical access in connected speech
samples. CoreLex checklists consist of lemmas that are scored as either
present (1) or absent (0), which makes scoring very simple.

CoreLex has shown good sensitivity in differentiating between controls
and individuals with aphasia (Dalton & Richardson, 2015; Fromm et al.,
2017), between individuals with fluent and non-fluent aphasia (Kim et
al., 2019; Kim et al., 2021), and between aphasia subtypes (Dalton &
Richardson, 2015; Fromm et al., 2017). Studies have also demonstrated
that CoreLex is related to standardized measures of aphasia (Kim et al.,
2019, Kim et al., 2021), other discourse measures (Alyahya et al., 2021;
Dalton & Richardson, 2019; Kim & Wright, 2020) and picture naming
(Alyahya et al., 2021). Preliminary evidence also suggests that corelex
might be sensitive to treatment-induced changes in some PWA (Dalton et
al., 2020; Dede & Hoover, 2021).

## About this web-app

Briefly, the app works by converting an orthographic transcription into
tokens, finding the lemma associated with each token, and matching these
lemmas with established core lexicon checklists. The user is asked to
double check that no core lexicon targets were missed, or identified in
error. A percentile score is then calculated using norms reported by
values in our publications (Richardson & Dalton, 2015, 2019; Dalton &
Richardson, 2018; Dalton et al., 2020), but are updated several times a
year with additional participants scored in Dr. Richardson’s lab. The
app is written in the {shiny} framework. The app is currently in Beta,
and is not yet ready for research or clinical deployment. Please note,
the app does not save any data from each user session.

## References

Dalton, S. G., & Richardson, J. D. (2015). Core-lexicon and main-concept
production during picture-sequence description in adults without brain
damage and adults with aphasia. American Journal of Speech-Language
Pathology, 24(4), S923-S938.

Dalton, S. G. H., Hubbard, H. I., & Richardson, J. D. (2020). Moving
toward non-transcription based discourse analysis in stable and
progressive aphasia. Seminars in Speech and Language, 41(1), 32-44.

Dalton, S. G. H., Kim, H., Richardson, J. D., & Wright, H. H. (2020). A
compendium of core lexicon checklists. Seminars in Speech and Language,
41(1), 45-60.

DeDe, G., & Hoover, E. (2021). Measuring Change at the Discourse-Level
Following Conversation Treatment: Examples From Mild and Severe Aphasia.
Topics in Language Disorders, 41(1), 5-26.

Fromm, D., Forbes, M., Holland, A., Dalton, S. G., Richardson, J., &
MacWhinney, B. (2017). Discourse characteristics in aphasia beyond the
Western Aphasia Battery cutoff. American Journal of Speech-Language
Pathology, 26(3), 762-768.

Kim, H., & Wright, H. H. (2020). Concurrent validity and reliability of
the core lexicon measure as a measure of word retrieval ability in
aphasia narratives. American Journal of Speech-Language Pathology,
29(1), 101-110.

Kim, H., Kintz, S., & Wright, H. H. (2021). Development of a measure of
function word use in narrative discourse: core lexicon analysis in
aphasia. International Journal of Language & Communication Disorders,
56(1), 6-19.

Kim, H., Kintz, S., Zelnosky, K., & Wright, H. H. (2019). Measuring word
retrieval in narrative discourse: Core lexicon in aphasia. International
Journal of Language & Communication Disorders, 54(1), 62-78.
