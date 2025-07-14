// Шаблон промпта для генерации сценария с помощью ChatGPT.
// В этот шаблон подставляются значения платформы, темы, аудитории, длины, стиля и призыва к действию.
// Итоговая строка отправляется в OpenAI API для генерации сценария.
// В конце промпта явно указано, что ответ должен быть в формате JSON с полями title и body.
const kScenarioPrompt =
    "You have to generate scenario for the {platform} short video. "
    "The theme of the video is {videoTheme}. Target audience is {targetAudience}. "
    "The length of the video should be {videoLength} seconds. "
    "The style of content is {contentStyle}. "
    "And in the end you should call for the action: {callToAction}. "
    "Return result in form of json with the following fields: title, body. Title and body are strings.";
