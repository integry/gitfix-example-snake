#!/bin/bash

# GitHub repository details
OWNER="integry"
REPO="gitfix-example-snake"
FULL_REPO="$OWNER/$REPO"

# --- Epic Description ---
EPIC_DESCRIPTION="This issue is part of an epic to develop a browser-based single-player 'snake-like' game. The goal is to incrementally build the game over 10 stages, starting with core mechanics and progressively adding features, visual enhancements, and polish to create a mindbogglingly flashy and addictive experience by the final stage. Each stage will result in a playable version of the game. The player character will be different each time the game is played."

# --- Helper function to create issue and add comment ---
# Due to the complexity of escaping JSON within a bash script for gh,
# it's often easier to write the body to a temporary file or use here-docs carefully.
# For this script, I will use direct heredocs for gh commands.

# --- Issue 1: Core Game Logic & Basic Rendering ---
ISSUE_1_TITLE="Game Stage 1/10: Core Game Logic & Basic Rendering"
ISSUE_1_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}

## 🚀 Current Stage Goal (1/10)
Implement the fundamental gameplay mechanics for a playable, albeit very basic, version of the snake game. This includes the game board, player character movement, food consumption, growth, game over conditions, and a basic score display.

## 📈 Status
* **Previous:** N/A (This is the first issue)
* **Current:** Establish core gameplay loop.
* **Next:** Enhance visuals and introduce static character variety.

## 📝 Detailed Description
This stage focuses on getting the bare essentials of the game working. The player will control a simple square character on a grid. Food will appear randomly, and consuming it will make the character grow and increase the score. The game ends if the character hits the boundaries of the game area or collides with itself.

##  Kontext
* **Environment:** Browser-based (HTML, CSS, JavaScript).
* **Rendering:** 2D Canvas API.
* **Controls:** Keyboard arrow keys.
* **Character:** A simple colored square.

## 🛠️ Implementation Steps
1.  **HTML Setup:** Create an \`index.html\` file with a \`<canvas>\` element for the game.
2.  **Game Grid:** Define dimensions for the game grid (e.g., 20x20 cells).
3.  **Player Character:**
    * Represent the character as an array of segments (initially one segment).
    * Implement movement logic (up, down, left, right) based on keyboard input (\`ArrowUp\`, \`ArrowDown\`, \`ArrowLeft\`, \`ArrowRight\`).
    * Render the character on the canvas (e.g., a green square).
4.  **Food:**
    * Implement logic to randomly place a food item (e.g., a red square) on an empty grid cell.
    * Detect collision between the character's head and the food.
    * When food is eaten:
        * Increase the player's score.
        * Grow the character by adding a new segment.
        * Place a new food item.
5.  **Game Over Conditions:**
    * Detect collision with the game boundaries.
    * Detect collision with the character's own body.
    * Implement a game over state (e.g., display "Game Over" and the final score).
6.  **Scoring:** Display the current score on the screen.
7.  **Game Loop:** Implement a main game loop (\`requestAnimationFrame\` or \`setInterval\`) to update game state and redraw the canvas.

## ✅ Acceptance Criteria
* Game initializes with a character and a food item on a grid.
* Player can control the character using arrow keys.
* Character grows when it eats food.
* Score increases when food is eaten.
* New food appears after one is eaten.
* Game ends and displays a "Game Over" message if the character hits a wall or itself.
* The current score is visible during gameplay.
EOF
)

ISSUE_1_COMMENT_CODE=$(cat <<'EOF'
~~~html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snake Game - Stage 1</title>
    <style>
        body { display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #333; }
        canvas { border: 1px solid white; }
    </style>
</head>
<body>
    <canvas id="gameCanvas"></canvas>
    <script src="game.js"></script>
</body>
</html>
~~~

~~~javascript
// game.js - Conceptual Outline
const canvas = document.getElementById('gameCanvas');
const context = canvas.getContext('2d');

const gridSize = 20; // Size of each grid cell in pixels
const tileCount = 20; // Number of cells in width/height

canvas.width = gridSize * tileCount;
canvas.height = gridSize * tileCount;

let snake = [{ x: 10, y: 10 }]; // Snake segments
let food = { x: 15, y: 15 };
let dx = 0; // Velocity x
let dy = 0; // Velocity y
let score = 0;

document.addEventListener('keydown', changeDirection);

function changeDirection(event) {
    // Basic direction change logic based on keyCode
    // Prevent snake from reversing on itself immediately
}

function gameLoop() {
    if (isGameOver()) {
        alert(\`Game Over! Score: \${score}\`);
        // Reset game or offer restart
        return;
    }

    setTimeout(() => {
        clearCanvas();
        moveSnake();
        drawFood();
        drawSnake();
        requestAnimationFrame(gameLoop);
    }, 100); // Adjust speed
}

function clearCanvas() {
    context.fillStyle = 'black';
    context.fillRect(0, 0, canvas.width, canvas.height);
}

function moveSnake() {
    // Update snake position
    // Check for food collision
    // Check for wall/self collision
}

function drawSnake() {
    context.fillStyle = 'lime';
    snake.forEach(segment => {
        context.fillRect(segment.x * gridSize, segment.y * gridSize, gridSize - 2, gridSize - 2);
    });
}

function drawFood() {
    context.fillStyle = 'red';
    context.fillRect(food.x * gridSize, food.y * gridSize, gridSize - 2, gridSize - 2);
}

function isGameOver() {
    // Implement collision detection logic
    return false; // Placeholder
}

// Initialize game
// drawScore(); // Implement score display
requestAnimationFrame(gameLoop);
~~~
EOF
)

echo "Creating Issue 1..."
ISSUE_1_ID=$(gh issue create --title "$ISSUE_1_TITLE" --body "$ISSUE_1_BODY" --repo "$FULL_REPO" | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_1_ID" ]; then
    echo "Issue 1 created with ID: $ISSUE_1_ID"
    gh issue comment "$ISSUE_1_ID" --body "$ISSUE_1_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_1_ID"
else
    echo "Failed to create Issue 1"
fi
PREVIOUS_ISSUE_ID=$ISSUE_1_ID

# --- Issue 2: Enhanced Visuals & Character Variety (Static) ---
ISSUE_2_TITLE="Game Stage 2/10: Enhanced Visuals & Static Character Variety"
ISSUE_2_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This issue builds upon the foundation laid in Stage 1 (Issue #${PREVIOUS_ISSUE_ID}).*

## 🚀 Current Stage Goal (2/10)
Improve the basic visuals of the game and introduce the core feature of having a different player character visual each time the game is played. This stage will focus on a small selection of static (non-animated) character appearances.

## 📈 Status
* **Previous:** Core game logic (movement, eating, growth, game over, score) is functional with a basic square character.
* **Current:** Enhance visual presentation slightly and implement a system for selecting one of 2-3 static character visuals at the start of each game.
* **Next:** Introduce basic animations and sound effects.

## 📝 Detailed Description
The game currently uses simple colored squares. This stage will involve:
1.  Defining 2-3 distinct visual styles for the player character (e.g., different simple shapes, emojis, or simple pixel art).
2.  Implementing a mechanism to randomly select one of these visual styles when a new game starts.
3.  Making minor improvements to the overall game aesthetics (e.g., better colors, a border for the game area).

##  Kontext
* Utilize the existing Canvas API for rendering.
* Character visuals should be simple to implement at this stage (e.g., drawing different shapes, rendering text/emoji, or using tiny pre-drawn images).

## 🛠️ Implementation Steps
1.  **Design Character Visuals:**
    * Create 2-3 distinct static visual representations for the player character.
    * Examples:
        * Character 1: Blue Circle
        * Character 2: Yellow Star (simple polygon)
        * Character 3: An emoji like 🐛 or 👻 (if canvas text rendering supports it well enough)
2.  **Character Selection Logic:**
    * Create an array or object holding the definitions for these characters.
    * At the start of each new game (or page load for now), randomly select one character visual to be used for that session.
    * Store the current character's rendering function or style properties.
3.  **Update Rendering Logic:**
    * Modify the \`drawSnake\` function to use the selected character's visual style for each segment.
    * Ensure the "head" of the character can be distinguished if necessary for the chosen visuals.
4.  **Visual Polish:**
    * Add a distinct border around the game canvas.
    * Choose a more appealing background color for the game area.
    * Slightly improve the food's appearance.
5.  **Display Current Character (Optional):** Display a small indicator or text showing which character is currently in play.

## ✅ Acceptance Criteria
* The game randomly selects one of 2-3 predefined visual styles for the player character upon starting.
* The chosen character visual is used to render the player character on the grid.
* The game board has a visible border and improved background color.
* Food item has a slightly improved visual.
* Core gameplay from Stage 1 remains fully functional.
EOF
)

ISSUE_2_COMMENT_CODE=$(cat <<'EOF'
~~~javascript
// game.js - Conceptual additions for Stage 2

// --- Character Definitions ---
const characters = [
    {
        name: "GreenSquare", // Keep the original as an option
        draw: (context, segment, gridSize, isHead) => {
            context.fillStyle = isHead ? 'darkgreen' : 'lime';
            context.fillRect(segment.x * gridSize, segment.y * gridSize, gridSize - 2, gridSize - 2);
        }
    },
    {
        name: "BlueCircle",
        draw: (context, segment, gridSize, isHead) => {
            context.fillStyle = isHead ? 'navy' : 'blue';
            context.beginPath();
            context.arc(segment.x * gridSize + gridSize / 2, segment.y * gridSize + gridSize / 2, (gridSize - 2) / 2, 0, 2 * Math.PI);
            context.fill();
        }
    },
    {
        name: "RedTriangle", // Example with a polygon
        draw: (context, segment, gridSize, isHead) => {
            context.fillStyle = isHead ? 'darkred' : 'red';
            context.beginPath();
            context.moveTo(segment.x * gridSize + gridSize / 2, segment.y * gridSize + 1); // Top point
            context.lineTo(segment.x * gridSize + 1, segment.y * gridSize + gridSize - 1); // Bottom-left
            context.lineTo(segment.x * gridSize + gridSize - 1, segment.y * gridSize + gridSize - 1); // Bottom-right
            context.closePath();
            context.fill();
        }
    }
    // Could also use emojis:
    // {
    //     name: "Caterpillar",
    //     emoji: "🐛",
    //     draw: (context, segment, gridSize, isHead) => {
    //         context.font = \`\${gridSize*0.8}px Arial\`;
    //         context.textAlign = 'center';
    //         context.textBaseline = 'middle';
    //         context.fillText(this.emoji, segment.x * gridSize + gridSize / 2, segment.y * gridSize + gridSize / 2);
    //     }
    // }
];

let currentCharacter;

function selectRandomCharacter() {
    const randomIndex = Math.floor(Math.random() * characters.length);
    currentCharacter = characters[randomIndex];
    console.log("Selected character:", currentCharacter.name);
}

// --- In your game initialization ---
// selectRandomCharacter(); // Call this before the game loop starts

// --- Modify drawSnake function ---
function drawSnake() {
    snake.forEach((segment, index) => {
        const isHead = (index === 0);
        currentCharacter.draw(context, segment, gridSize, isHead);
    });
}

// --- Style improvements ---
// In HTML/CSS:
// canvas { border: 2px solid #555; background-color: #222; }

// --- Food improvement example ---
function drawFood() {
    // Example: make food a pulsing circle or a different shape
    context.fillStyle = 'orange'; // Change color
    context.beginPath();
    context.arc(food.x * gridSize + gridSize / 2, food.y * gridSize + gridSize / 2, (gridSize - 2) / 2.5, 0, 2 * Math.PI);
    context.fill();

    // Or for a "fruit" emoji
    // context.font = \`\${gridSize*0.8}px Arial\`;
    // context.textAlign = 'center';
    // context.textBaseline = 'middle';
    // context.fillText("🍎", food.x * gridSize + gridSize / 2, food.y * gridSize + gridSize / 2);
}

// Remember to call selectRandomCharacter() when a new game starts.
// Example:
// function startGame() {
//     selectRandomCharacter();
//     resetGameState(); // snake position, score, etc.
//     if (!gameLoopRunning) gameLoop();
// }
~~~
EOF
)

echo "Creating Issue 2..."
ISSUE_2_ID=$(gh issue create --title "$ISSUE_2_TITLE" --body "$ISSUE_2_BODY" --repo "$FULL_REPO" | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_2_ID" ]; then
    echo "Issue 2 created with ID: $ISSUE_2_ID"
    gh issue comment "$ISSUE_2_ID" --body "$ISSUE_2_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_2_ID"
else
    echo "Failed to create Issue 2"
fi
PREVIOUS_ISSUE_ID=$ISSUE_2_ID


# --- Issue 3: Basic Animations & Sound Effects ---
ISSUE_3_TITLE="Game Stage 3/10: Basic Animations & Sound Effects"
ISSUE_3_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This issue builds upon Stage 2 (Issue #${PREVIOUS_ISSUE_ID}), which introduced static character variety.*

## 🚀 Current Stage Goal (3/10)
Make the game feel more dynamic and responsive by introducing basic animations for character movement and food consumption, along with simple sound effects for key game events.

## 📈 Status
* **Previous:** Core gameplay is functional, and the game features a selection of static visual characters chosen randomly. Basic visual polish applied.
* **Current:** Implement smooth character movement, food eating animation, and essential sound effects.
* **Next:** Implement a scoring system with high score persistence using localStorage.

## 📝 Detailed Description
Currently, the character likely "jumps" from one grid cell to another. This stage will smooth out that movement. Additionally, visual feedback for eating food will be enhanced, and audio cues will be added for important actions.

##  Kontext
* **Animation:** Primarily using Canvas API. For smooth movement, instead of directly updating grid positions, the character will interpolate its position between grid cells over time.
* **Sound:** Utilize the Web Audio API for playing simple sound effects. Source short, appropriate sound files (e.g., .wav or .mp3) or generate simple tones.

## 🛠️ Implementation Steps
1.  **Smooth Character Movement:**
    * Refactor the movement logic. The character's logical position will still be on the grid, but its rendered position will animate smoothly from its current cell to the next target cell.
    * This might involve updating rendering more frequently than game logic ticks or using a sub-grid positioning system for rendering.
2.  **Food Eating Animation:**
    * When food is eaten, trigger a small, quick animation at the food's location (e.g., a shrinking effect, a burst of particles, or the character "opening its mouth" if the visual allows).
3.  **Sound Effect Integration:**
    * Source or create simple sound effects for:
        * Eating food (e.g., a "crunch" or "blip" sound).
        * Game over (e.g., a "fail" or "explosion" sound).
        * Character movement (optional, a subtle "tick" or "swoosh" for each step).
    * Implement a helper function to load and play sound effects using the Web Audio API. Ensure sounds can be triggered reliably.
4.  **Audio Control (Optional but Recommended):** Add a simple mute/unmute button for sounds.

## ✅ Acceptance Criteria
* Player character animates smoothly between grid cells instead of instantly jumping.
* A noticeable visual animation occurs when the character eats food.
* A sound effect plays when food is eaten.
* A sound effect plays upon game over.
* (Optional) A subtle sound effect plays during character movement.
* (Optional) A mute button correctly toggles sound playback.
* Game performance remains good despite animations and sounds.
EOF
)

ISSUE_3_COMMENT_CODE=$(cat <<'EOF'
~~~javascript
// game.js - Conceptual additions for Stage 3

// --- Sound Effect Handling (Web Audio API) ---
let audioContext;
let soundEffects = {
    eat: null,
    gameOver: null,
    // move: null // Optional
};

function initAudio() {
    try {
        audioContext = new (window.AudioContext || window.webkitAudioContext)();
        loadSound('sounds/eat.wav', 'eat'); // Replace with actual paths
        loadSound('sounds/gameover.wav', 'gameOver');
        // loadSound('sounds/move.wav', 'move');
    } catch (e) {
        console.warn("Web Audio API is not supported in this browser.");
        audioContext = null;
    }
}

function loadSound(url, soundName) {
    if (!audioContext) return;
    const request = new XMLHttpRequest();
    request.open('GET', url, true);
    request.responseType = 'arraybuffer';
    request.onload = () => {
        audioContext.decodeAudioData(request.response, (buffer) => {
            soundEffects[soundName] = buffer;
        }, (e) => { console.error("Error decoding audio data", e); });
    };
    request.send();
}

function playSound(soundName) {
    if (audioContext && soundEffects[soundName] /* && !isMuted */) {
        const source = audioContext.createBufferSource();
        source.buffer = soundEffects[soundName];
        source.connect(audioContext.destination);
        source.start(0);
    }
}

// Call initAudio() once at the start.
// initAudio();

// --- Smooth Movement (Conceptual) ---
// This requires significant changes to gameLoop and drawing.
// Instead of snake segments having just {x, y} grid coordinates,
// they might need {currentX, currentY, targetX, targetY, animationProgress}
// or the rendering logic interpolates.

// Example: In your game loop for movement:
// Instead of: snakeHead.x += dx; snakeHead.y += dy;
// You'd set a target: snakeHead.targetX = snakeHead.x + dx; snakeHead.targetY = snakeHead.y + dy;
// Then, in the rendering part of the loop, you'd draw the snake at an interpolated position
// based on time passed or animation progress.
// This is a simplified concept. Actual implementation can be complex.

// --- Food Eating Animation ---
let foodAnimation = { active: false, x: 0, y: 0, progress: 0, duration: 10 }; // 10 frames duration

function triggerFoodEatAnimation(x, y) {
    foodAnimation.active = true;
    foodAnimation.x = x;
    foodAnimation.y = y;
    foodAnimation.progress = 0;
    playSound('eat'); // Play sound here
}

// In draw loop, if foodAnimation.active:
function drawFoodEatAnimation() {
    if (foodAnimation.active) {
        const animSize = gridSize * (1 - (foodAnimation.progress / foodAnimation.duration));
        context.fillStyle = 'rgba(255, 255, 0, 0.5)'; // Yellow burst
        context.beginPath();
        context.arc(
            foodAnimation.x * gridSize + gridSize / 2,
            foodAnimation.y * gridSize + gridSize / 2,
            animSize / 2, 0, 2 * Math.PI
        );
        context.fill();
        foodAnimation.progress++;
        if (foodAnimation.progress >= foodAnimation.duration) {
            foodAnimation.active = false;
        }
    }
}

// When food is eaten:
// triggerFoodEatAnimation(food.x, food.y);
// placeNewFood();

// In game over function:
// playSound('gameOver');

// --- HTML for Mute Button (example) ---
// <button id="muteButton">Mute</button>
// script:
// let isMuted = false;
// document.getElementById('muteButton').addEventListener('click', () => {
//     isMuted = !isMuted;
//     this.textContent = isMuted ? 'Unmute' : 'Mute';
// });
// Modify playSound to check isMuted.
~~~
You'll need to source or create actual sound files (e.g., 'eat.wav', 'gameover.wav') and place them in a 'sounds' directory or adjust paths.
For smooth animation, consider using `requestAnimationFrame` exclusively for the game loop and calculating movement based on delta time for frame-rate independence. The provided `setTimeout` in Stage 1 is basic; `requestAnimationFrame` is preferred for animations.
EOF
)

echo "Creating Issue 3..."
ISSUE_3_ID=$(gh issue create --title "$ISSUE_3_TITLE" --body "$ISSUE_3_BODY" --repo "$FULL_REPO"  | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_3_ID" ]; then
    echo "Issue 3 created with ID: $ISSUE_3_ID"
    gh issue comment "$ISSUE_3_ID" --body "$ISSUE_3_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_3_ID"
else
    echo "Failed to create Issue 3"
fi
PREVIOUS_ISSUE_ID=$ISSUE_3_ID


# --- Issue 4: Scoring System & Local Storage for High Scores ---
ISSUE_4_TITLE="Game Stage 4/10: Scoring System & Local Storage for High Scores"
ISSUE_4_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This issue builds upon Stage 3 (Issue #${PREVIOUS_ISSUE_ID}), which introduced animations and sound effects.*

## 🚀 Current Stage Goal (4/10)
Implement a more robust scoring system and persist high scores using the browser's localStorage, allowing players to track their best performances across game sessions.

## 📈 Status
* **Previous:** Game features smooth animations, basic sound effects, and randomly selected static characters. A basic score is already tracked.
* **Current:** Refine the scoring mechanism (if needed), store top high scores locally, and display them.
* **Next:** Introduce difficulty levels and adjust game speed accordingly.

## 📝 Detailed Description
While a basic score counter exists, this stage formalizes it and adds the ability to save and view high scores. This enhances player motivation and replayability.

##  Kontext
* **Scoring:** Points awarded per food item. Could be a fixed value (e.g., 10 points) or vary.
* **Storage:** Use \`localStorage\` to store an array or object of high scores.
* **Display:** High scores should be visible, typically on the game over screen or a dedicated "High Scores" view.

## 🛠️ Implementation Steps
1.  **Refine Scoring (If Necessary):**
    * Confirm the points awarded per food item. For now, a fixed value is fine.
    * Ensure the score is clearly displayed during gameplay.
2.  **High Score Logic:**
    * When a game ends, check if the player's score qualifies as a new high score (e.g., in the top 5).
    * If it's a high score:
        * Prompt the player for a name (optional, or use a default like "Player").
        * Add the new score (and name) to the list of high scores.
        * Keep the list sorted and limited (e.g., top 5 scores).
3.  **LocalStorage Integration:**
    * Create functions to save the high scores list to \`localStorage\` (e.g., as a JSON string).
    * Create a function to load high scores from \`localStorage\` when the game starts. If no scores exist, initialize with an empty list or default entries.
4.  **Display High Scores:**
    * On the game over screen, display the list of high scores.
    * Alternatively, create a separate button/link on the start screen to view high scores.
5.  **UI for High Scores:**
    * Present the scores clearly (e.g., Rank, Name, Score).

## ✅ Acceptance Criteria
* Current score is clearly displayed during gameplay.
* Upon game over, if the score is high enough, it's added to a persisted list of high scores.
* The top N (e.g., 5) high scores are saved in localStorage and persist between browser sessions.
* High scores (rank, name (if implemented), score) are displayed to the player (e.g., on the game over screen or a separate view).
* If no high scores are saved, a message indicating this or an empty list is shown.
EOF
)

ISSUE_4_COMMENT_CODE=$(cat <<'EOF'
~~~javascript
// game.js - Conceptual additions for Stage 4

const MAX_HIGH_SCORES = 5;
const HIGH_SCORES_KEY = 'snakeHighScores';

// --- Score variable (already exists, ensure it's used) ---
// let score = 0;

// --- Function to load high scores ---
function getHighScores() {
    const scoresJSON = localStorage.getItem(HIGH_SCORES_KEY);
    if (scoresJSON) {
        return JSON.parse(scoresJSON);
    }
    return []; // Return empty array if no scores are stored
}

// --- Function to save high scores ---
function saveHighScores(scores) {
    localStorage.setItem(HIGH_SCORES_KEY, JSON.stringify(scores));
}

// --- Function to add a new score ---
function addHighScore(newScore, playerName = "Player") {
    const highScores = getHighScores();
    const scoreEntry = { name: playerName, score: newScore, date: new Date().toLocaleDateString() };

    highScores.push(scoreEntry);
    highScores.sort((a, b) => b.score - a.score); // Sort descending by score
    highScores.splice(MAX_HIGH_SCORES); // Keep only top N scores

    saveHighScores(highScores);
}

// --- Called at Game Over ---
function handleGameOver() {
    // playSound('gameOver'); // From previous stage
    // alert(\`Game Over! Score: \${score}\`); // From previous stage

    // New high score logic
    const highScores = getHighScores();
    const lowestHighScore = highScores.length < MAX_HIGH_SCORES ? 0 : highScores[MAX_HIGH_SCORES - 1].score;

    if (score > lowestHighScore) {
        // Optional: Prompt for player name
        // const playerName = prompt("New High Score! Enter your name:", "Player");
        // addHighScore(score, playerName || "Player");
        addHighScore(score); // Simplified: no name prompt for now
        console.log("New high score added!");
    }
    displayHighScoresOnGameOver(); // Or update a dedicated high score screen
    // Offer restart option
}

// --- Display High Scores (Example: on game over screen or a dedicated element) ---
function displayHighScoresOnGameOver() {
    const highScores = getHighScores();
    let highScoreHtml = "<h3>High Scores:</h3><ol>";
    if (highScores.length === 0) {
        highScoreHtml += "<li>No high scores yet!</li>";
    } else {
        highScores.forEach(entry => {
            highScoreHtml += \`<li>\${entry.name} - \${entry.score} (\${entry.date})</li>\`;
        });
    }
    highScoreHtml += "</ol>";

    // Assuming you have a div with id="gameOverScreen" that becomes visible
    // and another div inside it with id="highScoresDisplay"
    const gameOverScreen = document.getElementById('gameOverScreen'); // You'd need to create this
    const highScoresDisplay = document.getElementById('highScoresDisplay'); // And this

    if (highScoresDisplay) {
        highScoresDisplay.innerHTML = highScoreHtml;
    } else { // Fallback to alert or console for simplicity if UI elements aren't set up
        console.log("High Scores:", highScores);
        // alert("High Scores:\n" + highScores.map(s => \`\${s.name}: \${s.score}\`).join("\n"));
    }
    if(gameOverScreen) gameOverScreen.style.display = 'block'; // Show game over screen
}

// --- Score Display during game ---
// Ensure you have an element (e.g., <div id="scoreDisplay">Score: 0</div>)
// And update it: document.getElementById('scoreDisplay').textContent = \`Score: \${score}\`;

// Modify your existing game over logic to call handleGameOver().
// For example, in isGameOver() or the part of gameLoop() that checks it:
// if (isGameOver()) {
//     handleGameOver();
//     return; // Stop the game loop
// }
~~~

~~~html
<div id="gameContainer">
    <canvas id="gameCanvas"></canvas>
    <div id="scoreDisplay">Score: 0</div>
</div>

<div id="gameOverScreen" style="display:none; text-align:center; color:white;">
    <h2>Game Over!</h2>
    <p>Your Score: <span id="finalScore">0</span></p>
    <div id="highScoresDisplay">
        </div>
    <button id="restartButton">Play Again</button>
</div>
~~~
Remember to update finalScore span in `handleGameOver` and implement `restartButton` functionality.
EOF
)

echo "Creating Issue 4..."
ISSUE_4_ID=$(gh issue create --title "$ISSUE_4_TITLE" --body "$ISSUE_4_BODY" --repo "$FULL_REPO"  | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_4_ID" ]; then
    echo "Issue 4 created with ID: $ISSUE_4_ID"
    gh issue comment "$ISSUE_4_ID" --body "$ISSUE_4_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_4_ID"
else
    echo "Failed to create Issue 4"
fi
PREVIOUS_ISSUE_ID=$ISSUE_4_ID


# --- Issue 5: Difficulty Levels & Game Speed ---
ISSUE_5_TITLE="Game Stage 5/10: Difficulty Levels & Game Speed"
ISSUE_5_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This issue builds upon Stage 4 (Issue #${PREVIOUS_ISSUE_ID}), which implemented high score persistence.*

## 🚀 Current Stage Goal (5/10)
Introduce difficulty levels to the game, primarily affecting the character's movement speed. This will cater to players of different skill levels and add to replayability.

## 📈 Status
* **Previous:** Game has core mechanics, varied static characters, basic animations/sounds, and high score tracking.
* **Current:** Implement selectable difficulty levels (e.g., Easy, Medium, Hard) that alter game speed.
* **Next:** Introduce power-ups and special food items.

## 📝 Detailed Description
Players should be able to choose a difficulty level before starting a game. Higher difficulty levels will mean faster character movement, making the game more challenging.

##  Kontext
* **UI:** Add a simple UI element (e.g., radio buttons or a dropdown) for selecting difficulty on the start screen.
* **Game Speed:** The game loop's interval or the character's movement update frequency will be adjusted based on the selected difficulty.

## 🛠️ Implementation Steps
1.  **Define Difficulty Levels:**
    * Establish 2-3 difficulty levels (e.g., "Easy", "Medium", "Hard").
    * For each level, define a corresponding game speed parameter (e.g., game loop interval in ms, or steps per second).
        * Easy: Slower speed (e.g., 150ms interval)
        * Medium: Normal speed (e.g., 100ms interval - possibly current default)
        * Hard: Faster speed (e.g., 70ms interval)
2.  **Difficulty Selection UI:**
    * Add HTML elements (e.g., radio buttons, a select dropdown) on the game's start screen or main page to allow the player to choose a difficulty.
    * Store the selected difficulty setting.
3.  **Apply Difficulty to Game Speed:**
    * Modify the game loop timing (\`setTimeout\` delay or logic within \`requestAnimationFrame\` if using delta time) to reflect the chosen difficulty.
    * Ensure the new game starts with the selected speed.
4.  **Visual Feedback (Optional):** Display the selected difficulty level during the game or on the game over screen.
5.  **Default Difficulty:** Set a default difficulty (e.g., Medium) if none is selected.

## ✅ Acceptance Criteria
* Player can select a difficulty level (e.g., Easy, Medium, Hard) before starting a game.
* The character's movement speed changes according to the selected difficulty (faster for harder levels).
* The game remains playable and fair at all difficulty levels.
* A default difficulty is applied if the player doesn't make a selection.
* Core game features from previous stages remain functional.
EOF
)

ISSUE_5_COMMENT_CODE=$(cat <<'EOF'
~~~html
<div id="startScreen">
    <h1>Snake-Like Game</h1>
    <div>
        <label for="difficulty">Choose Difficulty:</label>
        <select id="difficultySelect">
            <option value="easy">Easy</option>
            <option value="medium" selected>Medium</option>
            <option value="hard">Hard</option>
        </select>
    </div>
    <button id="startGameButton">Start Game</button>
    </div>

<div id="gameArea" style="display:none;">
    <canvas id="gameCanvas"></canvas>
    <div id="scoreDisplay">Score: 0</div>
    <div id="currentDifficultyDisplay">Difficulty: Medium</div>
</div>
~~~

~~~javascript
// game.js - Conceptual additions for Stage 5

const difficultySettings = {
    easy: { speed: 150, name: "Easy" },    // Milliseconds per update
    medium: { speed: 100, name: "Medium" },
    hard: { speed: 70, name: "Hard" }
};
let currentDifficulty = difficultySettings.medium; // Default
let gameLoopTimeoutId; // To control the game loop with setTimeout

// --- UI Elements ---
const difficultySelect = document.getElementById('difficultySelect');
const startGameButton = document.getElementById('startGameButton'); // Assuming you have one
const startScreen = document.getElementById('startScreen');
const gameArea = document.getElementById('gameArea');
const currentDifficultyDisplay = document.getElementById('currentDifficultyDisplay');

// --- Event Listener for Start Button ---
if (startGameButton) {
    startGameButton.addEventListener('click', () => {
        const selectedValue = difficultySelect.value;
        currentDifficulty = difficultySettings[selectedValue];

        if (currentDifficultyDisplay) {
            currentDifficultyDisplay.textContent = \`Difficulty: \${currentDifficulty.name}\`;
        }
        
        // Hide start screen, show game area
        if(startScreen) startScreen.style.display = 'none';
        if(gameArea) gameArea.style.display = 'block'; // Or however you manage views

        initializeGame(); // Reset game state and start
    });
}


// --- Game Initialization (to be called by startGameButton) ---
function initializeGame() {
    // Reset snake, score, food position, etc.
    snake = [{ x: 10, y: 10 }];
    dx = 0; dy = 0; // Stop initial movement until first key press
    score = 0;
    // updateScoreDisplay(); // You'll need this function
    placeNewFood();
    // selectRandomCharacter(); // From Stage 2
    
    // Clear any existing game loop and start a new one
    if (gameLoopTimeoutId) clearTimeout(gameLoopTimeoutId);
    gameLoop(); // Start the game loop with the new speed
}


// --- Modified Game Loop (if using setTimeout) ---
function gameLoop() {
    if (isGameOver()) {
        handleGameOver(); // From Stage 4
        return;
    }

    // Clear previous timeout if any, then set new one with current difficulty speed
    if (gameLoopTimeoutId) clearTimeout(gameLoopTimeoutId);
    gameLoopTimeoutId = setTimeout(() => {
        clearCanvas();
        // drawFoodEatAnimation(); // from stage 3
        moveSnake();
        drawFood();
        drawSnake();
        // drawScore();

        // Call gameLoop again for the next frame
        // If using requestAnimationFrame, you'd adjust movement speed based on delta time
        // and currentDifficulty.speed would represent something like "updates per second"
        // which influences how much the snake moves per frame.
        gameLoop(); 
    }, currentDifficulty.speed);
}

// If you are using requestAnimationFrame for your main loop (preferred for animation stage):
// let lastUpdateTime = 0;
// let gameSpeedFactor; // e.g., pixels per second or grid cells per second

// function gameLoopRAF(timestamp) {
//     if (isGameOver()) {
//         handleGameOver();
//         return;
//     }
//     const deltaTime = timestamp - lastUpdateTime;
//     if (deltaTime > currentDifficulty.speed) { // currentDifficulty.speed would be minimum ms between logic updates
//         lastUpdateTime = timestamp;
//         // Update game logic (moveSnake, check collisions, etc.)
//         clearCanvas();
//         moveSnake(); // This function would handle the actual movement based on dx, dy
//     }
//     // Drawing can happen every frame
//     drawFood();
//     drawSnake();
//     // drawScore();
//     requestAnimationFrame(gameLoopRAF);
// }
// To start: lastUpdateTime = 0; requestAnimationFrame(gameLoopRAF);
// The 'speed' in difficultySettings might then control how often 'moveSnake' logic is allowed to run
// or how many units the snake moves per logic update.
// For simplicity with the existing structure, setTimeout is shown above.
// Choose one consistent game loop mechanism.

// Call initializeGame() or similar function when "Start Game" is clicked.
// Ensure the game stops (clearTimeout) when navigating away or game over.
~~~
Note: The example shows `setTimeout` for simplicity based on Stage 1's basic loop. If you've transitioned to `requestAnimationFrame` (recommended for Stage 3's smooth animations), you'd adjust game speed by changing how frequently the snake's logical position updates or how far it moves per update, rather than changing the `setTimeout` delay. The key is that `currentDifficulty.speed` influences the actual rate of play.
EOF
)

echo "Creating Issue 5..."
ISSUE_5_ID=$(gh issue create --title "$ISSUE_5_TITLE" --body "$ISSUE_5_BODY" --repo "$FULL_REPO"  | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_5_ID" ]; then
    echo "Issue 5 created with ID: $ISSUE_5_ID"
    gh issue comment "$ISSUE_5_ID" --body "$ISSUE_5_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_5_ID"
else
    echo "Failed to create Issue 5"
fi
PREVIOUS_ISSUE_ID=$ISSUE_5_ID

# --- Issue 6: Power-ups & Special Food Items ---
ISSUE_6_TITLE="Game Stage 6/10: Power-ups & Special Food Items"
ISSUE_6_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This issue builds upon Stage 5 (Issue #${PREVIOUS_ISSUE_ID}), which introduced difficulty levels.*

## 🚀 Current Stage Goal (6/10)
Add more gameplay variety and excitement by introducing 1-2 types of power-ups or special food items that provide temporary benefits or unique effects.

## 📈 Status
* **Previous:** Game has selectable difficulty levels affecting speed, along with core mechanics, character variety, animations/sounds, and high scores.
* **Current:** Implement logic for special items to appear, be collected, and trigger effects.
* **Next:** Implement dynamic backgrounds and themes.

## 📝 Detailed Description
Beyond regular food, special items will occasionally appear on the game board. Collecting these items will grant the player a temporary advantage, making the gameplay more dynamic and strategic.

##  Kontext
* **Item Spawning:** Special items should appear less frequently than regular food and possibly disappear after a certain time if not collected.
* **Effects:** Define clear effects for each power-up.
* **Visuals:** Power-ups need distinct visual representations.
* **Feedback:** Visual and audio feedback when a power-up is collected and when its effect is active/expires.

## 🛠️ Implementation Steps
1.  **Design Power-ups (1-2 types):**
    * **Type 1: Score Multiplier:** For a short duration (e.g., 10 seconds), each food item eaten gives 2x or 3x points.
        * Visual: e.g., a sparkling or golden apple.
    * **Type 2: Slow Motion:** Temporarily reduces game speed for a few seconds, even on harder difficulties.
        * Visual: e.g., a snail icon or a clock icon.
    * *(Optional: Shield/Invincibility, Shrink Snake, Bonus Points, etc.)*
2.  **Power-up Spawning Logic:**
    * Determine conditions for spawning power-ups (e.g., after a certain number of regular foods eaten, random chance over time).
    * Ensure power-ups don't spawn on the snake or existing food.
    * (Optional) Make power-ups disappear if not collected within a certain timeframe.
3.  **Collection and Effect Activation:**
    * Detect collision between the character and a power-up.
    * When collected:
        * Remove the power-up from the board.
        * Play a distinct sound effect.
        * Activate its effect (e.g., set a flag for score multiplier, adjust game speed temporarily).
        * Use timers (\`setTimeout\`) to manage the duration of effects.
4.  **Visual and Audio Feedback:**
    * Power-ups must have unique appearances on the canvas.
    * Provide visual indication when a power-up is active (e.g., change character color, display an icon on screen).
    * Play a sound when a power-up effect wears off.
5.  **Balancing:** Adjust spawn rates and effect durations for balanced gameplay.

## ✅ Acceptance Criteria
* At least one new type of power-up/special food item can appear on the game board.
* Power-ups have distinct visuals from regular food.
* Collecting a power-up triggers its specific effect (e.g., score multiplier, slow motion).
* Power-up effects are temporary and expire after a set duration.
* Visual and audio feedback is provided for power-up collection, active state, and expiration.
* (Optional) Power-ups disappear if not collected in time.
EOF
)

ISSUE_6_COMMENT_CODE=$(cat <<'EOF'
~~~javascript
// game.js - Conceptual additions for Stage 6

let powerUps = []; // Array to hold active power-ups on screen: {x, y, type, lifetimeTimerId, visual}
const POWERUP_LIFETIME = 10000; // 10 seconds for a power-up to be collected
const POWERUP_SPAWN_CHANCE = 0.1; // 10% chance after eating normal food, or use a counter

// --- Power-up Types ---
const powerUpTypes = {
    SCORE_MULTIPLIER: {
        name: "Score x2",
        duration: 10000, // 10 seconds
        visual: (ctx, item, gs) => { // gs is gridSize
            ctx.fillStyle = 'gold';
            ctx.beginPath();
            ctx.arc(item.x * gs + gs / 2, item.y * gs + gs / 2, gs / 2.5, 0, Math.PI * 2);
            ctx.fill();
            ctx.fillStyle = 'yellow'; // Sparkle
            ctx.fillText('x2', item.x * gs + gs / 2, item.y * gs + gs / 2);
        },
        activate: () => {
            activeEffects.scoreMultiplier = true;
            // playSound('powerUpActivate');
            setTimeout(() => {
                activeEffects.scoreMultiplier = false;
                // playSound('powerUpExpire');
            }, powerUpTypes.SCORE_MULTIPLIER.duration);
        }
    },
    SLOW_MOTION: {
        name: "Slow Motion",
        duration: 7000, // 7 seconds
        visual: (ctx, item, gs) => {
            ctx.fillStyle = 'cyan';
            ctx.fillRect(item.x * gs + gs / 4, item.y * gs + gs / 4, gs / 2, gs / 2);
            ctx.fillText('S', item.x * gs + gs / 2, item.y * gs + gs / 2); // Simple 'S'
        },
        activate: () => {
            activeEffects.slowMotion = true;
            const originalSpeed = currentDifficulty.speed;
            currentDifficulty.speed *= 1.5; // Slow down (increase interval)
            // playSound('powerUpActivate');
            setTimeout(() => {
                activeEffects.slowMotion = false;
                currentDifficulty.speed = originalSpeed; // Restore speed
                // playSound('powerUpExpire');
            }, powerUpTypes.SLOW_MOTION.duration);
        }
    }
};

let activeEffects = {
    scoreMultiplier: false,
    slowMotion: false
};

// --- Spawning Power-ups ---
function trySpawnPowerUp() {
    if (Math.random() < POWERUP_SPAWN_CHANCE && powerUps.length === 0) { // Only one power-up at a time for simplicity
        let newPowerUpX, newPowerUpY;
        // Find empty spot logic (similar to food spawning)
        // ... (ensure it's not on snake or food)
        const types = Object.keys(powerUpTypes);
        const randomTypeKey = types[Math.floor(Math.random() * types.length)];
        
        // Placeholder for position finding
        newPowerUpX = Math.floor(Math.random() * tileCount);
        newPowerUpY = Math.floor(Math.random() * tileCount);

        const newPowerUp = {
            x: newPowerUpX,
            y: newPowerUpY,
            type: randomTypeKey,
            visual: powerUpTypes[randomTypeKey].visual
        };

        // Optional: Make power-up disappear after some time
        newPowerUp.lifetimeTimerId = setTimeout(() => {
            powerUps = powerUps.filter(p => p !== newPowerUp);
            // console.log("Power-up expired");
        }, POWERUP_LIFETIME);

        powerUps.push(newPowerUp);
    }
}

// --- Drawing Power-ups ---
function drawPowerUps() {
    powerUps.forEach(p => {
        powerUpTypes[p.type].visual(context, p, gridSize);
    });
}

// --- Collision with Power-ups (in moveSnake or collision check) ---
function checkPowerUpCollision() {
    const head = snake[0];
    powerUps.forEach((p, index) => {
        if (head.x === p.x && head.y === p.y) {
            powerUpTypes[p.type].activate();
            clearTimeout(p.lifetimeTimerId); // Clear disappearance timer
            powerUps.splice(index, 1); // Remove collected power-up
        }
    });
}

// --- Modify scoring logic for multiplier ---
// When eating regular food:
// let points = 10; // Base points
// if (activeEffects.scoreMultiplier) {
//     points *= 2;
//     // Add visual feedback for multiplied score if possible
// }
// score += points;
// updateScoreDisplay();

// --- Game Loop calls ---
// In gameLoop:
// drawPowerUps();

// In moveSnake (after moving, before drawing):
// checkPowerUpCollision();

// When regular food is eaten:
// trySpawnPowerUp();

// --- Visual feedback for active effects (example) ---
// function drawActiveEffects() {
//     context.fillStyle = 'white';
//     context.font = '12px Arial';
//     let yOffset = 20;
//     if (activeEffects.scoreMultiplier) {
//         context.fillText("Score x2 Active!", canvas.width - 100, yOffset);
//         yOffset += 15;
//     }
//     if (activeEffects.slowMotion) {
//         context.fillText("Slow Motion Active!", canvas.width - 100, yOffset);
//     }
// }
// Call drawActiveEffects() in the main draw/render part of your game loop.

// Remember to add sound effects for power-up spawn, collect, and expire.
// (e.g., 'sounds/powerup_spawn.wav', 'sounds/powerup_collect.wav', 'sounds/powerup_expire.wav')
// And integrate them with playSound().
~~~
This is a conceptual outline. You'll need to integrate these parts carefully into your existing game structure, especially collision detection, spawning logic (to avoid overlaps), and the game loop.
EOF
)

echo "Creating Issue 6..."
ISSUE_6_ID=$(gh issue create --title "$ISSUE_6_TITLE" --body "$ISSUE_6_BODY" --repo "$FULL_REPO"  | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_6_ID" ]; then
    echo "Issue 6 created with ID: $ISSUE_6_ID"
    gh issue comment "$ISSUE_6_ID" --body "$ISSUE_6_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_6_ID"
else
    echo "Failed to create Issue 6"
fi
PREVIOUS_ISSUE_ID=$ISSUE_6_ID


# --- Issue 7: Dynamic Backgrounds & Themes ---
ISSUE_7_TITLE="Game Stage 7/10: Dynamic Backgrounds & Themes"
ISSUE_7_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This issue builds upon Stage 6 (Issue #${PREVIOUS_ISSUE_ID}), which introduced power-ups.*

## 🚀 Current Stage Goal (7/10)
Significantly enhance the visual appeal of the game by implementing 2-3 different visual themes. These themes will include different background images/patterns, grid colors, and potentially styles for food and the character.

## 📈 Status
* **Previous:** Game includes power-ups, difficulty levels, high scores, character variety, animations, and sounds.
* **Current:** Develop and integrate selectable or rotating visual themes to diversify the game's look.
* **Next:** Implement advanced character animations and personalities.

## 📝 Detailed Description
To make the game more visually engaging, this stage focuses on creating distinct themes. A theme could change the game's background (static image, generated pattern, or subtle animation), the color of the grid lines (if any), and even the default appearance of food items if not overridden by special types.

##  Kontext
* **Assets:** May require simple background images or procedural generation for patterns.
* **Theme Switching:** Themes could be selectable by the player at the start screen or could change randomly per game or after achieving certain milestones.
* **Canvas Rendering:** Backgrounds will be drawn on the canvas behind the game elements.

## 🛠️ Implementation Steps
1.  **Design Themes (2-3 options):**
    * **Theme 1: "Classic Pixel":** Dark background, bright neon grid (optional), pixelated food/character styles.
    * **Theme 2: "Garden":** Greenish background (grass texture or pattern), fruit-like food, perhaps a flowery border.
    * **Theme 3: "Space":** Dark blue/purple space background with stars (static image or simple particle stars), planet-like food.
    * For each theme, define: background (color, image, pattern), grid line color (if visible), default food appearance.
2.  **Asset Creation/Sourcing:**
    * If using images, create or find small, tileable, or appropriately sized background images.
    * For patterns, develop simple procedural generation functions (e.g., stripes, dots, simple noise).
3.  **Theme Management Logic:**
    * Create a structure (e.g., an object or array) to hold theme definitions.
    * Implement logic to select a theme:
        * Option A: Player selection via UI on the start screen.
        * Option B: Randomly selected at the start of each new game.
    * Store the currently active theme.
4.  **Update Rendering Functions:**
    * Modify the main drawing function (\`clearCanvas\` or equivalent) to draw the active theme's background first.
    * If themes affect grid lines or default food visuals, adjust \`drawGrid\` (if you have one) and \`drawFood\` accordingly.
    * Ensure character visuals (from Stage 2) and power-up visuals (from Stage 6) still stand out against the new backgrounds.
5.  **Performance Considerations:** If using complex backgrounds or animations, ensure the game's performance is not negatively impacted. Static images or simple patterns are usually safe.

## ✅ Acceptance Criteria
* At least two distinct visual themes are implemented.
* The game can switch between themes (either player-selected or randomly).
* Each theme provides a unique background and potentially different styling for grid/food.
* Game elements (character, food, power-ups) are clearly visible against all themes.
* Game performance remains smooth with the new themes.
EOF
)

ISSUE_7_COMMENT_CODE=$(cat <<'EOF'
~~~javascript
// game.js - Conceptual additions for Stage 7

const themes = {
    classic: {
        name: "Classic Pixel",
        backgroundColor: '#111', // Dark background
        gridColor: '#333', // Optional grid lines
        foodColor: 'red', // Default food color
        // snakeColor: 'lime', // Could also be part of theme if not character specific
        drawBackground: (ctx, canvas) => {
            ctx.fillStyle = themes.classic.backgroundColor;
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            // Optional: Draw grid lines
            if (themes.classic.gridColor) {
                ctx.strokeStyle = themes.classic.gridColor;
                for (let x = 0; x <= canvas.width; x += gridSize) {
                    ctx.beginPath();
                    ctx.moveTo(x, 0);
                    ctx.lineTo(x, canvas.height);
                    ctx.stroke();
                }
                for (let y = 0; y <= canvas.height; y += gridSize) {
                    ctx.beginPath();
                    ctx.moveTo(0, y);
                    ctx.lineTo(canvas.width, y);
                    ctx.stroke();
                }
            }
        }
    },
    garden: {
        name: "Garden",
        backgroundImage: null, // Will load an Image object
        // backgroundImageSrc: 'path/to/garden_bg.png', // Or use a color
        backgroundColor: '#90EE90', // Light green
        foodStyle: 'apple', // Could map to a specific draw function for food
        drawBackground: (ctx, canvas) => {
            if (themes.garden.backgroundImage && themes.garden.backgroundImage.complete) {
                ctx.drawImage(themes.garden.backgroundImage, 0, 0, canvas.width, canvas.height);
            } else {
                ctx.fillStyle = themes.garden.backgroundColor;
                ctx.fillRect(0, 0, canvas.width, canvas.height);
            }
            // Add other garden-themed elements if desired, e.g., a subtle pattern
        }
    },
    space: {
        name: "Space",
        backgroundColor: '#000020', // Deep dark blue
        stars: [], // Array for star particles {x, y, radius}
        numStars: 50,
        drawBackground: (ctx, canvas) => {
            ctx.fillStyle = themes.space.backgroundColor;
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = 'white';
            themes.space.stars.forEach(star => {
                ctx.beginPath();
                ctx.arc(star.x, star.y, star.radius, 0, Math.PI * 2);
                ctx.fill();
            });
        },
        init: (canvas) => { // Initialize stars for space theme
            if (themes.space.stars.length === 0) {
                for (let i = 0; i < themes.space.numStars; i++) {
                    themes.space.stars.push({
                        x: Math.random() * canvas.width,
                        y: Math.random() * canvas.height,
                        radius: Math.random() * 1.5
                    });
                }
            }
        }
    }
};

let currentTheme = themes.classic; // Default theme

// --- Function to load image assets for themes (if any) ---
function loadThemeAssets() {
    if (themes.garden.backgroundImageSrc && !themes.garden.backgroundImage) {
        themes.garden.backgroundImage = new Image();
        themes.garden.backgroundImage.onload = () => {
            console.log("Garden background loaded.");
            // Force a redraw if game is active or on next game start
        };
        themes.garden.backgroundImage.src = themes.garden.backgroundImageSrc;
    }
    // Initialize theme-specific things like stars for space
    if (currentTheme.init) {
        currentTheme.init(canvas);
    }
}
// Call loadThemeAssets() once at startup.

// --- UI for Theme Selection (example in HTML) ---
// <select id="themeSelect">
//     <option value="classic">Classic</option>
//     <option value="garden">Garden</option>
//     <option value="space">Space</option>
// </select>
// document.getElementById('themeSelect').addEventListener('change', (event) => {
//     currentTheme = themes[event.target.value];
//     if (currentTheme.init) currentTheme.init(canvas); // Re-init if necessary
//     // If game is not running, changes apply on next start. If running, might need a redraw.
// });

// --- Modified clearCanvas (or your main draw background function) ---
function renderBackground() { // Renamed from clearCanvas to be more descriptive
    currentTheme.drawBackground(context, canvas);
}

// --- Game Loop Modification ---
// In your main game loop's drawing phase:
// function gameDraw() {
//    renderBackground(); // Draws the theme's background
//    drawFood();         // Food might need to respect theme.foodStyle
//    drawSnake();
//    drawPowerUps();
//    drawScore();
//    drawActiveEffects();
//    drawFoodEatAnimation();
// }
// Call this from requestAnimationFrame or your setTimeout loop's drawing step.

// --- Modifying drawFood for themes ---
// function drawFood() {
//    if (currentTheme.foodStyle === 'apple' && currentTheme === themes.garden) {
//        // Draw a special apple for garden theme
//        context.fillStyle = 'red'; // Simple example
//        context.beginPath();
//        context.arc(food.x * gridSize + gridSize / 2, food.y * gridSize + gridSize / 2, gridSize / 2.2, 0, Math.PI * 2);
//        context.fill();
//        context.fillStyle = 'darkgreen'; // Stem
//        context.fillRect(food.x * gridSize + gridSize / 2 - 1, food.y * gridSize, 2, gridSize / 4);
//    } else {
//        // Default food drawing or theme's default food color
//        context.fillStyle = currentTheme.foodColor || 'purple'; // Fallback
//        context.fillRect(food.x * gridSize, food.y * gridSize, gridSize - 2, gridSize - 2);
//    }
// }

// Initial setup:
// loadThemeAssets();
// If allowing theme selection before game starts:
// const savedTheme = localStorage.getItem('selectedTheme');
// if (savedTheme && themes[savedTheme]) {
//    currentTheme = themes[savedTheme];
//    if (currentTheme.init) currentTheme.init(canvas);
// }
// document.getElementById('themeSelect').value = Object.keys(themes).find(key => themes[key] === currentTheme);
~~~
Place background images in an accessible path relative to your HTML file or use full URLs. `backgroundImageSrc` is a placeholder for the actual image path. The Space theme's stars are static once generated; for animated stars, you'd update their positions in `drawBackground`.
EOF
)

echo "Creating Issue 7..."
ISSUE_7_ID=$(gh issue create --title "$ISSUE_7_TITLE" --body "$ISSUE_7_BODY" --repo "$FULL_REPO"  | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_7_ID" ]; then
    echo "Issue 7 created with ID: $ISSUE_7_ID"
    gh issue comment "$ISSUE_7_ID" --body "$ISSUE_7_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_7_ID"
else
    echo "Failed to create Issue 7"
fi
PREVIOUS_ISSUE_ID=$ISSUE_7_ID


# --- Issue 8: Advanced Character Animations & Personalities ---
ISSUE_8_TITLE="Game Stage 8/10: Advanced Character Animations & Personalities"
ISSUE_8_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This issue builds upon Stage 7 (Issue #${PREVIOUS_ISSUE_ID}), which introduced dynamic backgrounds and themes.*

## 🚀 Current Stage Goal (8/10)
Make the player characters more lively and distinct by expanding the character pool and giving each character more unique animations (e.g., idle, eating, "hurt" when hitting a wall). This will enhance the "different character every time" aspect.

## 📈 Status
* **Previous:** Game has visual themes, power-ups, difficulty levels, high scores, and basic character variety/animation.
* **Current:** Implement more detailed animations for characters, potentially using sprite sheets or more complex procedural animations. Give characters more "personality."
* **Next:** Focus on overall visual polish and special effects.

## 📝 Detailed Description
Go beyond simple shape changes or basic movement. Characters should have more expressive animations:
* **Idle Animation:** A subtle animation when the character is not moving (if applicable to snake movement).
* **Eating Animation:** A more pronounced animation when food is consumed, specific to the character's design.
* **Turning Animation:** Character's head or body might visually react to turns.
* **Hurt/Game Over Animation:** A specific animation when the character collides or the game ends.
The idea is to make each randomly selected character feel more unique in its behavior and appearance.

##  Kontext
* **Animation Techniques:** This could involve using sprite sheets for frame-by-frame animation if characters are pixel art, or more complex drawing logic for procedurally animated characters.
* **Character Design:** Requires designing these new animation states for a few selected characters.
* **State Management:** The character object will need to manage its current animation state (e.g., 'moving', 'eating', 'idle').

## 🛠️ Implementation Steps
1.  **Expand Character Roster (Optional):** If current characters are too simple, consider redesigning 2-3 of them or adding new ones suitable for more advanced animation.
2.  **Define Animation States:** For each chosen character, define key animation states:
    * Default/Moving (could have subtle variations like blinking, breathing).
    * Eating (e.g., mouth opens, a gulping motion).
    * Turning (e.g., head slightly tilts or body bends more visibly).
    * Hurt/Impact (e.g., brief flash, change of expression, shake).
    * Game Over (a final "defeat" pose or effect).
3.  **Create Animation Assets/Logic:**
    * **Sprite Sheets:** If using sprites, create small sprite sheets for each character's animations. Implement a sprite rendering function that can play specific animation sequences from a sheet.
    * **Procedural Animation:** For canvas-drawn characters, write functions that modify the drawing parameters over several frames to create the animation (e.g., scaling parts, moving sub-components, changing colors).
4.  **Integrate Animations into Game Logic:**
    * Trigger animations based on game events:
        * Update the 'moving' animation continuously.
        * Switch to 'eating' animation when food is collected.
        * Play 'hurt' animation briefly on collision (before game over if it's not an instant game over).
        * Play 'game over' animation when the game ends.
    * The character's main draw function will need to select and render the current animation frame.
5.  **Character "Personality" (Subtle Touches):**
    * Slight variations in movement style (e.g., one character wiggles more, another moves more rigidly).
    * Character-specific sound variations for eating or movement, if not overly complex.

## ✅ Acceptance Criteria
* At least 2-3 characters have noticeably enhanced animations beyond simple movement.
* Characters display distinct animations for events like eating or game over.
* The selected character's unique animations are used throughout the game session.
* Animations are smooth and contribute positively to the game's feel without performance issues.
* The "personality" of different characters starts to become more apparent.
EOF
)

ISSUE_8_COMMENT_CODE=$(cat <<'EOF'
~~~javascript
// game.js - Conceptual additions for Stage 8

// --- Enhanced Character Definitions (Example with Sprite Sheet idea) ---
// This assumes you have a sprite sheet image and know frame details.
// For procedural animation, the 'frames' would be drawing functions or parameters.

const advancedCharacters = {
    pixelWorm: {
        name: "Pixel Worm",
        spriteSheetSrc: 'sprites/pixel_worm.png',
        spriteSheet: null, // Loaded Image object
        frameSize: { width: 24, height: 24 }, // Size of one frame in the sprite sheet
        animations: {
            idle: { frames: [0, 1], speed: 300 }, // frame indices, ms per frame
            move: { frames: [2, 3, 4, 5], speed: 100 },
            eat: { frames: [6, 7, 6], speed: 150, nextState: 'move' }, // After eating, go back to move
            turn: { frames: [8], speed: 100, nextState: 'move' }, // A single frame for a quick turn indication
            hurt: { frames: [9], speed: 500, nextState: 'move' } // Flashing or dazed
        },
        currentAnimation: 'move',
        currentFrameIndex: 0,
        lastFrameTime: 0,
        draw: function(context, segment, gs, isHead, snakeInstance) {
            if (!this.spriteSheet || !this.spriteSheet.complete) {
                // Fallback drawing if sprite not loaded
                context.fillStyle = 'purple';
                context.fillRect(segment.x * gs, segment.y * gs, gs - 2, gs - 2);
                return;
            }

            const anim = this.animations[this.currentAnimation];
            if (!anim) return;

            // Update frame for animation
            const now = Date.now();
            if (now - (this.lastFrameTime || 0) > anim.speed) {
                this.currentFrameIndex = (this.currentFrameIndex + 1) % anim.frames.length;
                this.lastFrameTime = now;
                if (this.currentFrameIndex === 0 && anim.nextState) {
                    this.currentAnimation = anim.nextState; // Transition to next state
                }
            }
            
            const frame = anim.frames[this.currentFrameIndex];
            const sx = frame * this.frameSize.width; // Source X on sprite sheet
            const sy = 0; // Assuming horizontal sprite strip, change if vertical

            // Rotate context for head direction (complex, simplified here)
            // let angle = 0;
            // if (isHead) {
            //    if (snakeInstance.dx === 1) angle = 0;
            //    else if (snakeInstance.dx === -1) angle = Math.PI;
            //    else if (snakeInstance.dy === 1) angle = Math.PI / 2;
            //    else if (snakeInstance.dy === -1) angle = -Math.PI / 2;
            //    context.save();
            //    context.translate(segment.x * gs + gs / 2, segment.y * gs + gs / 2);
            //    context.rotate(angle);
            //    context.drawImage(this.spriteSheet, sx, sy, this.frameSize.width, this.frameSize.height,
            //                      -gs / 2, -gs / 2, gs, gs);
            //    context.restore();
            // } else {
                 context.drawImage(this.spriteSheet, sx, sy, this.frameSize.width, this.frameSize.height,
                                   segment.x * gs, segment.y * gs, gs, gs);
            // }
        },
        setAnimation: function(animName) {
            if (this.animations[animName] && this.currentAnimation !== animName) {
                this.currentAnimation = animName;
                this.currentFrameIndex = 0;
                this.lastFrameTime = Date.now(); // Reset time for new animation
            }
        }
    }
    // ... other advanced characters
};

// --- Load Character Assets ---
function loadCharacterAssets() {
    const charKey = 'pixelWorm'; // Example
    if (advancedCharacters[charKey] && advancedCharacters[charKey].spriteSheetSrc && !advancedCharacters[charKey].spriteSheet) {
        advancedCharacters[charKey].spriteSheet = new Image();
        advancedCharacters[charKey].spriteSheet.onload = () => {
            console.log(\`\${advancedCharacters[charKey].name} sprite sheet loaded.\`);
        };
        advancedCharacters[charKey].spriteSheet.src = advancedCharacters[charKey].spriteSheetSrc;
    }
    // Potentially add more characters to the `characters` array from Stage 2,
    // or replace it if all characters are now advanced.
    // For now, assume `currentCharacter` (from Stage 2) can hold an advancedCharacter object.
}
// Call loadCharacterAssets() at startup.

// --- Modifying `selectRandomCharacter` (from Stage 2) ---
// Ensure it can select from these new advanced characters.
// currentCharacter = advancedCharacters.pixelWorm; // Example, replace with random selection logic.

// --- In `drawSnake` (from Stage 2) ---
// function drawSnake() {
//     snake.forEach((segment, index) => {
//         const isHead = (index === 0);
//         if (typeof currentCharacter.draw === 'function') {
//             currentCharacter.draw(context, segment, gridSize, isHead, {dx: dx, dy: dy} /* pass snake instance or relevant parts */);
//         } else {
//             // Fallback to simpler drawing
//             context.fillStyle = 'gray';
//             context.fillRect(segment.x * gridSize, segment.y * gridSize, gridSize - 2, gridSize - 2);
//         }
//     });
// }

// --- Triggering Animations ---
// Example: When food is eaten
// if (collidedWithFood) {
//     // ... existing logic ...
//     if (typeof currentCharacter.setAnimation === 'function') {
//         currentCharacter.setAnimation('eat');
//     }
//     // ...
// }

// Example: Game Over
// function handleGameOver() {
//     // ... existing logic ...
//     if (typeof currentCharacter.setAnimation === 'function') {
//         currentCharacter.setAnimation('hurt'); // Or a specific 'gameOver' animation
//     }
//     // ...
// }

// Example: In moveSnake, after direction change:
// if (directionChangedThisTick && typeof currentCharacter.setAnimation === 'function') {
//     currentCharacter.setAnimation('turn');
// } else if (typeof currentCharacter.setAnimation === 'function' && currentCharacter.currentAnimation !== 'eat') {
//    // Ensure it's in 'move' state if not doing a special action
//    currentCharacter.setAnimation('move');
// }

// Need to ensure the character's `lastFrameTime` is initialized correctly,
// and that the `draw` method is called within the game's animation loop
// so frame updates can be timed.
~~~
This stage requires more significant art/asset work if using sprite sheets. Procedural animation avoids external assets but needs careful coding for each effect. The example focuses on a sprite sheet approach. Head rotation adds complexity; if segments are just parts of a body, rotation might only apply to the head sprite.
The `snakeInstance` or relevant parts like `dx, dy` are passed to `draw` for context, e.g., to determine head orientation.
Remember to replace the placeholder `characters` array/object with these advanced ones, or merge them.
EOF
)

echo "Creating Issue 8..."
ISSUE_8_ID=$(gh issue create --title "$ISSUE_8_TITLE" --body "$ISSUE_8_BODY" --repo "$FULL_REPO"  | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_8_ID" ]; then
    echo "Issue 8 created with ID: $ISSUE_8_ID"
    gh issue comment "$ISSUE_8_ID" --body "$ISSUE_8_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_8_ID"
else
    echo "Failed to create Issue 8"
fi
PREVIOUS_ISSUE_ID=$ISSUE_8_ID


# --- Issue 9: Visual Polish & Special Effects ("Juice") ---
ISSUE_9_TITLE="Game Stage 9/10: Visual Polish & Special Effects ('Juice')"
ISSUE_9_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This issue builds upon Stage 8 (Issue #${PREVIOUS_ISSUE_ID}), which implemented advanced character animations.*

## 🚀 Current Stage Goal (9/10)
Make the game "flashy" and more engaging by adding "juice" – particle effects, screen shake, transition animations, and overall refinement of UI elements for a polished look and feel.

## 📈 Status
* **Previous:** Characters have advanced animations and personalities. Game includes themes, power-ups, difficulty, etc.
* **Current:** Add a layer of polish with dynamic visual feedback like particle effects and screen shake. Refine UI.
* **Next:** Final "addictive" features, more sound/music, and overall polish.

## 📝 Detailed Description
This stage is about enhancing the player's sensory experience through satisfying visual feedback for game events.
* **Particle Effects:** Small, numerous sprites or shapes that move and fade, used for events like eating food, power-up activation, collisions, or character trails.
* **Screen Shake:** Briefly shaking the game canvas to add impact to events like game over or collecting a powerful item.
* **UI Polish:** Improve the appearance of buttons, score displays, game over screen, etc., for a cohesive and professional look.
* **Transitions:** Smooth transitions between game states (e.g., start screen to game, game to game over screen).

##  Kontext
* **Canvas:** Effects will be rendered on the main game canvas or potentially an overlay canvas.
* **Performance:** Effects should be optimized to not degrade performance. Object pooling for particles can be useful.

## 🛠️ Implementation Steps
1.  **Particle System:**
    * Implement a basic particle emitter and particle update logic. Particles typically have properties like position, velocity, color, size, and lifespan.
    * Create particle effects for:
        * Food being eaten (e.g., a burst of small particles).
        * Power-up collection (e.g., a radial burst of colored particles).
        * Character movement trail (optional, subtle particles left behind the character).
        * Impacts/Game Over (e.g., an "explosion" of particles).
2.  **Screen Shake Effect:**
    * Implement a function that can temporarily offset the canvas rendering position randomly by a few pixels for a short duration.
    * Trigger screen shake for:
        * Game over.
        * Collecting a significant power-up.
        * (Optional) Minor shake for character collisions with walls if not game over.
3.  **UI Refinement:**
    * Review all UI elements (start screen, game HUD, game over screen, buttons, text).
    * Apply consistent styling (fonts, colors, spacing, button styles) that matches the game's overall aesthetic.
    * Consider using custom fonts if appropriate.
4.  **Transitions:**
    * Implement simple fade-in/fade-out transitions for screens (e.g., when starting a game or showing the game over screen).
    * Animate score updates (e.g., numbers quickly counting up).
5.  **Subtle Background Animations (Theme dependent):**
    * If themes allow (e.g., Space theme), add subtle animations like twinkling stars or slowly drifting elements.

## ✅ Acceptance Criteria
* Particle effects are present for key game events (eating, power-up collection, game over).
* Screen shake effect is implemented and used appropriately for impactful events.
* UI elements have a polished and consistent appearance.
* Transitions between game states are smoother (e.g., fades).
* The game feels more dynamic and visually rewarding ("juicy").
* Performance remains high.
EOF
)

ISSUE_9_COMMENT_CODE=$(cat <<'EOF'
~~~javascript
// game.js - Conceptual additions for Stage 9

// --- Basic Particle System ---
let particles = [];
const MAX_PARTICLES = 100; // Max particles on screen

function createParticle(x, y, count, color, life, speedRange, sizeRange) {
    for (let i = 0; i < count; i++) {
        if (particles.length >= MAX_PARTICLES) return;
        const angle = Math.random() * Math.PI * 2;
        const speed = speedRange.min + Math.random() * (speedRange.max - speedRange.min);
        particles.push({
            x: x, y: y,
            vx: Math.cos(angle) * speed,
            vy: Math.sin(angle) * speed,
            life: life + Math.random() * life * 0.5, // Randomize life a bit
            initialLife: life,
            color: color,
            size: sizeRange.min + Math.random() * (sizeRange.max - sizeRange.min)
        });
    }
}

function updateAndDrawParticles(ctx) {
    for (let i = particles.length - 1; i >= 0; i--) {
        const p = particles[i];
        p.x += p.vx;
        p.y += p.vy;
        p.vy += 0.05; // Gravity effect, optional
        p.life--;

        if (p.life <= 0) {
            particles.splice(i, 1);
            continue;
        }

        ctx.globalAlpha = Math.max(0, p.life / p.initialLife); // Fade out
        ctx.fillStyle = p.color;
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.size * (p.life / p.initialLife), 0, Math.PI * 2); // Shrink
        ctx.fill();
    }
    ctx.globalAlpha = 1.0; // Reset global alpha
}

// --- Screen Shake ---
let screenShake = { duration: 0, magnitude: 0, x: 0, y: 0 };

function triggerScreenShake(durationMs, magnitude) {
    screenShake.duration = durationMs;
    screenShake.magnitude = magnitude;
}

function applyScreenShake(ctx) { // Call before drawing game elements
    if (screenShake.duration > 0) {
        screenShake.duration -= (1000/60); // Assuming 60 FPS, roughly
        const sx = (Math.random() - 0.5) * 2 * screenShake.magnitude;
        const sy = (Math.random() - 0.5) * 2 * screenShake.magnitude;
        screenShake.x = sx;
        screenShake.y = sy;
        ctx.translate(sx, sy);
    } else {
        screenShake.x = 0;
        screenShake.y = 0;
    }
}
function resetScreenShake(ctx) { // Call after drawing game elements
    if (screenShake.x !== 0 || screenShake.y !== 0) {
        ctx.translate(-screenShake.x, -screenShake.y);
    }
}

// --- Example Usage ---
// When food is eaten:
// createParticle(food.x * gridSize + gridSize / 2, food.y * gridSize + gridSize / 2,
//                10, 'yellow', 30, {min:0.5, max:1.5}, {min:1, max:3});

// Game Over:
// triggerScreenShake(500, 5); // Shake for 500ms with magnitude 5
// createParticle(snake[0].x * gridSize, snake[0].y * gridSize,
//                50, 'red', 60, {min:1, max:3}, {min:2, max:5}); // Explosion


// --- UI Polish (CSS examples) ---
/*
In your style.css:
body { font-family: 'Arial', sans-serif; /* Or a cool game font */ }
button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 8px;
    transition: background-color 0.3s ease;
}
button:hover { background-color: #45a049; }

#scoreDisplay { font-size: 24px; color: #FFF; text-shadow: 1px 1px #333; }
#gameOverScreen { /* Add nice styling, transitions */ }
*/

// --- Transitions (JS for fade example) ---
// function fadeScreen(elementId, fadeIn, duration = 500, callback) {
//     const element = document.getElementById(elementId);
//     if (!element) return;
//     let startOpacity = fadeIn ? 0 : 1;
//     let endOpacity = fadeIn ? 1 : 0;
//     element.style.opacity = startOpacity;
//     if (fadeIn) element.style.display = 'block'; // Or other appropriate display type

//     let startTime = null;
//     function animate(currentTime) {
//         if (startTime === null) startTime = currentTime;
//         const elapsedTime = currentTime - startTime;
//         const progress = Math.min(elapsedTime / duration, 1);
//         element.style.opacity = startOpacity + (endOpacity - startOpacity) * progress;

//         if (progress < 1) {
//             requestAnimationFrame(animate);
//         } else {
//             if (!fadeIn) element.style.display = 'none';
//             if (callback) callback();
//         }
//     }
//     requestAnimationFrame(animate);
// }
// Example: fadeScreen('startScreen', false, 500, () => fadeScreen('gameArea', true));

// --- Game Loop Modifications ---
// In main draw function (e.g., gameDraw):
// applyScreenShake(context); // BEFORE drawing anything else
// renderBackground();
// drawFood();
// drawSnake();
// drawPowerUps();
// updateAndDrawParticles(context); // Draw particles on top
// drawUIElements(); // Score, etc.
// resetScreenShake(context); // AFTER drawing everything that should shake
~~~
For particle effects, consider an object pool if creating/destroying many particles frequently to optimize performance. Screen shake is applied by translating the canvas context. UI Polish involves CSS and potentially DOM manipulation for smoother transitions. Use `requestAnimationFrame` for smooth JavaScript animations like fades.
EOF
)

echo "Creating Issue 9..."
ISSUE_9_ID=$(gh issue create --title "$ISSUE_9_TITLE" --body "$ISSUE_9_BODY" --repo "$FULL_REPO"  | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_9_ID" ]; then
    echo "Issue 9 created with ID: $ISSUE_9_ID"
    gh issue comment "$ISSUE_9_ID" --body "$ISSUE_9_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_9_ID"
else
    echo "Failed to create Issue 9"
fi
PREVIOUS_ISSUE_ID=$ISSUE_9_ID


# --- Issue 10: "Mindbogglingly Addictive" Features & Final Polish ---
ISSUE_10_TITLE="Game Stage 10/10: Addictive Features, Music & Final Polish"
ISSUE_10_BODY=$(cat <<EOF
${EPIC_DESCRIPTION}
*This is the final stage, building upon Stage 9 (Issue #${PREVIOUS_ISSUE_ID}) which added visual polish and special effects.*

## 🚀 Current Stage Goal (10/10)
Elevate the game to be "mindbogglingly flashy and addictive." This involves introducing features that encourage re-engagement, adding a fitting background music track, refining sound design, and conducting a final overall polish of gameplay, visuals, and performance.

## 📈 Status
* **Previous:** Game is visually polished with particle effects, screen shake, advanced character animations, themes, power-ups, etc.
* **Current:** Implement features to boost addictiveness (e.g., combo system/frenzy mode), add background music, refine all sounds, and ensure the game is extremely responsive and smooth.
* **Next:** N/A (This is the final core development stage of the epic).

## 📝 Detailed Description
This final push aims to maximize player enjoyment and the desire to play "just one more time."
1.  **Addictive Gameplay Mechanic (e.g., Combo/Frenzy Mode):**
    * Reward players for skillful or rapid play. Example: Eating multiple food items quickly (within a short time window of each other) could build a combo meter.
    * Filling the combo meter might trigger a temporary "Frenzy Mode" (e.g., faster snake, bonus points, special visual effects, unique music sting).
2.  **Background Music & Enhanced Sound Design:**
    * Select or compose 1-2 catchy, upbeat background music tracks appropriate for the game's style.
    * Implement music playback with a mute option (if not already fully implemented for sounds).
    * Review and refine all existing sound effects for clarity, impact, and satisfaction. Add new ones if needed (e.g., for combo system).
3.  **Game Over Flair:**
    * Make the game over sequence more engaging. Perhaps a short, fun animation of the character's "demise" or a more visually appealing score screen.
4.  **Final Character Polish:**
    * If any character designs or animations still feel lacking, give them a final touch-up.
5.  **Performance Optimization & Bug Squashing:**
    * Thoroughly test the game on different browsers/devices (if targeting mobile indirectly via browser).
    * Profile for performance bottlenecks and optimize critical code paths.
    * Fix any remaining bugs or glitches.
6.  **Controls Responsiveness:** Ensure controls are ultra-responsive and feel intuitive.
7.  **Overall "Feel":** Playtest extensively to fine-tune difficulty, power-up balance, pacing, and the overall satisfaction of playing.

## ✅ Acceptance Criteria
* A new gameplay mechanic (e.g., combo/frenzy mode) is implemented and adds to addictiveness.
* Background music is present with a mute control, enhancing the game's atmosphere.
* Sound effects are well-polished and satisfying.
* The game over sequence is more engaging.
* The game is highly responsive, performs smoothly, and is largely bug-free.
* The final game product is considered "flashy and addictive."
EOF
)

ISSUE_10_COMMENT_CODE=$(cat <<'EOF'
~~~javascript
// game.js - Conceptual additions for Stage 10

// --- Combo/Frenzy Mode System ---
let comboCounter = 0;
let lastFoodEatTime = 0;
const COMBO_WINDOW_MS = 2000; // 2 seconds to continue combo
const FRENZY_THRESHOLD = 5; // Need 5 combo to trigger frenzy
let isFrenzyMode = false;
const FRENZY_DURATION_MS = 10000; // 10 seconds

function recordFoodEat() {
    const now = Date.now();
    if (now - lastFoodEatTime < COMBO_WINDOW_MS) {
        comboCounter++;
    } else {
        comboCounter = 1; // Reset or start combo
    }
    lastFoodEatTime = now;
    // playSound('comboTick'); // Sound for each combo increment

    if (comboCounter >= FRENZY_THRESHOLD && !isFrenzyMode) {
        activateFrenzyMode();
    }

    // Update UI to show comboCounter if desired
    // document.getElementById('comboDisplay').textContent = \`Combo: \${comboCounter}\`;
}

function activateFrenzyMode() {
    isFrenzyMode = true;
    // playSound('frenzyActivate');
    // visualFeedbackForFrenzy(true); // e.g. change background, snake flashes, etc.
    // Modify game parameters: e.g., snake speed up, points multiply more

    setTimeout(() => {
        deactivateFrenzyMode();
    }, FRENZY_DURATION_MS);
}

function deactivateFrenzyMode() {
    isFrenzyMode = false;
    comboCounter = 0; // Reset combo after frenzy
    // playSound('frenzyEnd');
    // visualFeedbackForFrenzy(false);
    // Restore normal game parameters
    // document.getElementById('comboDisplay').textContent = "";
}

// --- Background Music ---
let bgMusic = null; // new Audio('music/upbeat_track.mp3');
let isMusicMuted = false; // Separate from sound effects mute if desired

function setupMusic() {
    bgMusic = new Audio('music/upbeat_track.mp3'); // Replace with actual path
    bgMusic.loop = true;
    // Optional: Load from localStorage
    // isMusicMuted = localStorage.getItem('musicMuted') === 'true';
    // document.getElementById('musicMuteButton').textContent = isMusicMuted ? "Unmute Music" : "Mute Music";
    if (!isMusicMuted) {
        // bgMusic.play().catch(e => console.warn("Music play failed", e)); // Autoplay might be blocked
    }
}
// Call setupMusic() on game load. User interaction might be needed to start music.

// document.getElementById('musicMuteButton').addEventListener('click', () => {
//     isMusicMuted = !isMusicMuted;
//     if (isMusicMuted) {
//         bgMusic.pause();
//     } else {
//         bgMusic.play().catch(e => console.warn("Music play failed", e));
//     }
//     // this.textContent = isMusicMuted ? "Unmute Music" : "Mute Music";
//     // localStorage.setItem('musicMuted', isMusicMuted);
// });

// --- Game Over Flair Example ---
// function displayGameOverFancy() {
//     // Previous game over logic (scores, etc.)
//     handleGameOver(); // from Stage 4

//     // Add some flair:
//     // - Special animation of the character (using Stage 8's animation system)
//     // - More dynamic presentation of the score (e.g., numbers counting up quickly)
//     // - "Try Again?" button with more prominent styling
//     // - Maybe a "ghost" of the snake's path briefly appears?
//     const gameOverScreen = document.getElementById('gameOverScreen');
//     gameOverScreen.classList.add('fancy-game-over'); // Add CSS class for styling
// }
// Ensure your CSS has .fancy-game-over styles.

// --- Final Polish Points ---
// 1. Controls: Ensure keydown events are processed immediately.
//    Check for any lag between key press and snake reaction.
// 2. Performance: Use browser dev tools (Profiler) to check for bottlenecks.
//    - Optimize drawing: avoid redundant canvas operations.
//    - Object pooling for particles (Stage 9) if not already robust.
//    - Efficient collision detection.
// 3. Balancing: Playtest all difficulty levels.
//    - Are power-ups too common/rare? Too strong/weak?
//    - Is the game too easy/hard initially? Does difficulty scale well?
// 4. Bug Hunt: Test edge cases:
//    - Rapid direction changes.
//    - Pausing/unpausing (if implemented).
//    - Window resize behavior.

// Hook `recordFoodEat()` into your food consumption logic.
// Modify scoring during frenzy mode if that's part of its effect.
// Example:
// if (collidedWithFood) {
//    let points = 10;
//    if (isFrenzyMode) points *= 3; // Frenzy bonus
//    else if (activeEffects.scoreMultiplier) points *=2; // Regular power-up bonus
//    score += points;
//    recordFoodEat(); // This must be called AFTER score calculation if it affects points for current food
//    // ... rest of food eating logic
// }
~~~
This final stage is about tying everything together and adding that extra layer that makes a game truly engaging. Focus on the feel of the game. The "Frenzy Mode" is just one idea; other addictive mechanics could be "achievements" (tracked in localStorage), daily challenges (if game had a date concept), or a "near miss" bonus system.
Remember to source appropriate music and sound effects.
EOF
)

echo "Creating Issue 10..."
ISSUE_10_ID=$(gh issue create --title "$ISSUE_10_TITLE" --body "$ISSUE_10_BODY" --repo "$FULL_REPO" | grep -o '[0-9]*$')
if [ ! -z "$ISSUE_10_ID" ]; then
    echo "Issue 10 created with ID: $ISSUE_10_ID"
    gh issue comment "$ISSUE_10_ID" --body "$ISSUE_10_COMMENT_CODE" --repo "$FULL_REPO"
    echo "Added code suggestion to Issue $ISSUE_10_ID"
else
    echo "Failed to create Issue 10"
fi

echo "All issues created for $FULL_REPO."