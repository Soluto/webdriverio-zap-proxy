var assert = require('assert');

describe('webdriver.io page', function() {

    it('should have the right title - the fancy generator way', function () {
        browser.url('/');
        var title = browser.getTitle();
        assert.notEqual(title, '');
    });

});
