const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');
const scoreElement = document.getElementById('score');
const gameOverElement = document.getElementById('gameOver');

const GRID_SIZE = 20;
const TILE_COUNT = canvas.width / GRID_SIZE;

let snake = [{ x: 10, y: 10 }];
let dx = 0;
let dy = 0;
let food = { x: 15, y: 15 };
let score = 0;
let gameRunning = true;

function drawRect(x, y, color) {
    ctx.fillStyle = color;
    ctx.fillRect(x * GRID_SIZE, y * GRID_SIZE, GRID_SIZE - 2, GRID_SIZE - 2);
}

function drawSnake() {
    ctx.fillStyle = '#4CAF50';
    snake.forEach(segment => {
        drawRect(segment.x, segment.y, '#4CAF50');
    });
}

function drawFood() {
    drawRect(food.x, food.y, '#FF5722');
}

function clearCanvas() {
    ctx.fillStyle = '#000';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
}

function generateFood() {
    let newFood;
    do {
        newFood = {
            x: Math.floor(Math.random() * TILE_COUNT),
            y: Math.floor(Math.random() * TILE_COUNT)
        };
    } while (snake.some(segment => segment.x === newFood.x && segment.y === newFood.y));
    
    food = newFood;
}

function moveSnake() {
    if (!gameRunning) return;

    const head = { x: snake[0].x + dx, y: snake[0].y + dy };

    if (head.x < 0 || head.x >= TILE_COUNT || head.y < 0 || head.y >= TILE_COUNT) {
        gameOver();
        return;
    }

    if (snake.some(segment => segment.x === head.x && segment.y === head.y)) {
        gameOver();
        return;
    }

    snake.unshift(head);

    if (head.x === food.x && head.y === food.y) {
        score += 10;
        scoreElement.textContent = `Score: ${score}`;
        generateFood();
    } else {
        snake.pop();
    }
}

function gameOver() {
    gameRunning = false;
    gameOverElement.style.display = 'block';
}

function resetGame() {
    snake = [{ x: 10, y: 10 }];
    dx = 0;
    dy = 0;
    score = 0;
    gameRunning = true;
    scoreElement.textContent = `Score: ${score}`;
    gameOverElement.style.display = 'none';
    generateFood();
}

function handleKeyPress(event) {
    if (!gameRunning) {
        if (event.key === ' ') {
            resetGame();
        }
        return;
    }

    switch (event.key) {
        case 'ArrowUp':
            if (dy !== 1) {
                dx = 0;
                dy = -1;
            }
            break;
        case 'ArrowDown':
            if (dy !== -1) {
                dx = 0;
                dy = 1;
            }
            break;
        case 'ArrowLeft':
            if (dx !== 1) {
                dx = -1;
                dy = 0;
            }
            break;
        case 'ArrowRight':
            if (dx !== -1) {
                dx = 1;
                dy = 0;
            }
            break;
    }
}

function gameLoop() {
    clearCanvas();
    moveSnake();
    drawFood();
    drawSnake();
}

document.addEventListener('keydown', handleKeyPress);

generateFood();

setInterval(gameLoop, 150);