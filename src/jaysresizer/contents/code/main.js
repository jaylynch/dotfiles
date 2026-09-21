function setNewGeometry(x, y, width, height) {
  const newFrameGeometry = {
    x: x,
    y: y,
    width: width,
    height: height
  };

  debug(JSON.stringify(newFrameGeometry));
  workspace.activeWindow.frameGeometry = newFrameGeometry;
}

function resizeByRowAndColumn(rows, columns, selectRow, selectColumn) {
  const window = workspace.activeWindow;
  if (!window) {
    debug("no active window");
    return;
  }

  const screen = workspace.clientArea(KWin.MaximizeArea, window);
  const rowHeight = screen.height / rows;
  const colWidth = screen.width / columns;

  const newX = screen.x + (selectColumn * colWidth);
  const newY = screen.y + (selectRow * rowHeight);

  setNewGeometry(newX, newY, colWidth, rowHeight);
}

function debug(message) {
  console.info("jaysresizer: " + message);
}

function safely(name, callback) {
  return function () {
    debug(name + " invoked");

    try {
      callback();
    } catch (error) {
      console.error(
        "jaysresizer: " + name + " failed: " +
        error.name + ": " + error.message + "\n" + error.stack
      );
    }
  };
}

// Tall halves
registerShortcut(
  "jaysresizer-left-half",
  "Resize active window to left half of current screen",
  "Ctrl+Alt+Q",
  safely("Left half", function () {
    resizeByRowAndColumn(1, 2, 0, 0);
  })
);

registerShortcut(
  "jaysresizer-right-half",
  "Resize active window to right half of current screen",
  "Ctrl+Alt+E",
  safely("Right half", function () {
    resizeByRowAndColumn(1, 2, 0, 1);
  })
);

// Tall thirds
registerShortcut(
  "jaysresizer-left-third",
  "Resize active window to left third of current screen",
  "Ctrl+Alt+Shift+Q",
  safely("Left third", function () {
    resizeByRowAndColumn(1, 3, 0, 0);
  })
);

registerShortcut(
  "jaysresizer-middle-third",
  "Resize active window to middle third of current screen",
  "Ctrl+Alt+Shift+W",
  safely("Middle third", function () {
    resizeByRowAndColumn(1, 3, 0, 1);
  })
);

registerShortcut(
  "jaysresizer-right-third",
  "Resize active window to right third of current screen",
  "Ctrl+Alt+Shift+E",
  safely("Right third", function () {
    resizeByRowAndColumn(1, 3, 0, 2);
  })
);

// Sixths
registerShortcut(
  "jaysresizer-top-left-sixth",
  "Resize active window to top left sixth of current screen",
  "Ctrl+Alt+Meta+Q",
  safely("Top left sixth", function () {
    resizeByRowAndColumn(2, 3, 0, 0);
  })
);

registerShortcut(
  "jaysresizer-top-middle-sixth",
  "Resize active window to top middle sixth of current screen",
  "Ctrl+Alt+Meta+W",
  safely("Top middle sixth", function () {
    resizeByRowAndColumn(2, 3, 0, 1);
  })
);

registerShortcut(
  "jaysresizer-top-right-sixth",
  "Resize active window to top right sixth of current screen",
  "Ctrl+Alt+Meta+E",
  safely("Top right sixth", function () {
    resizeByRowAndColumn(2, 3, 0, 2);
  })
);

registerShortcut(
  "jaysresizer-bottom-left-sixth",
  "Resize active window to bottom left sixth of current screen",
  "Ctrl+Alt+Meta+A",
  safely("Bottom left sixth", function () {
    resizeByRowAndColumn(2, 3, 1, 0);
  })
);

registerShortcut(
  "jaysresizer-bottom-middle-sixth",
  "Resize active window to bottom middle sixth of current screen",
  "Ctrl+Alt+Meta+S",
  safely("Bottom middle sixth", function () {
    resizeByRowAndColumn(2, 3, 1, 1);
  })
);

registerShortcut(
  "jaysresizer-bottom-right-sixth",
  "Resize active window to bottom right sixth of current screen",
  "Ctrl+Alt+Meta+D",
  safely("Bottom right sixth", function () {
    resizeByRowAndColumn(2, 3, 1, 2);
  })
);

// Quarters
registerShortcut(
  "jaysresizer-top-left-quarter",
  "Resize active window to top left quarter of current screen",
  "Ctrl+Alt+Meta+1",
  safely("Top left quarter", function () {
    resizeByRowAndColumn(2, 2, 0, 0);
  })
);

registerShortcut(
  "jaysresizer-top-right-quarter",
  "Resize active window to top right quarter of current screen",
  "Ctrl+Alt+Meta+2",
  safely("Top right quarter", function () {
    resizeByRowAndColumn(2, 2, 0, 1);
  })
);

registerShortcut(
  "jaysresizer-bottom-left-quarter",
  "Resize active window to bottom left quarter of current screen",
  "Ctrl+Alt+Meta+3",
  safely("Bottom left quarter", function () {
    resizeByRowAndColumn(2, 2, 1, 0);
  })
);

registerShortcut(
  "jaysresizer-bottom-right-quarter",
  "Resize active window to bottom right quarter of current screen",
  "Ctrl+Alt+Meta+4",
  safely("Bottom right quarter", function () {
    resizeByRowAndColumn(2, 2, 1, 1);
  })
);

// Test output on init - should show when script is enabled in KWin config UI
debug("script loaded");
