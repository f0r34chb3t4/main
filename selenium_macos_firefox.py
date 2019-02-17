from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.firefox_profile import FirefoxProfile
from selenium.webdriver.common.keys import Keys
import sys

# macos_firefox.py
# /Applications/Firefox.app/Contents/MacOS/firefox  --private-window https://www.uol.com.br

# Options
firefox_options = Options()
firefox_options.log.level = 'debug'
firefox_options.add_argument('-private')
firefox_options.accept_untrusted_certs = True
firefox_options.assume_untrusted_cert_issuer = True
firefox_options.binary_location = '/Applications/Firefox.app/Contents/MacOS/firefox'
# firefox_options.headless = True

# FirefoxProfile
firefox_profile = FirefoxProfile();
firefox_profile.set_preference('browser.privatebrowsing.autostart', True)
firefox_profile.set_preference('pdfjs.disabled', True)
firefox_profile.set_preference('browser.download.folderList', 2)
firefox_profile.set_preference('browser.download.panel.shown', False)
firefox_profile.set_preference('browser.tabs.warnOnClose', False)
firefox_profile.set_preference('browser.tabs.animate', False)
firefox_profile.set_preference('browser.fullscreen.animateUp', 0)
firefox_profile.set_preference('geo.enabled', False)
firefox_profile.set_preference('browser.urlbar.suggest.searches', False)
firefox_profile.set_preference('browser.tabs.warnOnCloseOtherTabs', False)
firefox_profile.update_preferences()

# DesiredCapabilities
firefox_capabilities = webdriver.DesiredCapabilities.FIREFOX.copy()
firefox_capabilities['marionette'] = True
firefox_capabilities['acceptInsecureCerts'] = True

# iniciar navegador
w = webdriver.Firefox(options=firefox_options, firefox_profile=firefox_profile,
                      desired_capabilities=firefox_capabilities)

# tempo de espera padrao
w.implicitly_wait(15)

w.get('https://www.uol.com.br')

w.quit()

sys.exit(0)
