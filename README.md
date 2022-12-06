<!-- Output copied to clipboard! -->

<!-----

Yay, no errors, warnings, or alerts!

Conversion time: 0.637 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β33
* Mon Dec 05 2022 18:17:31 GMT-0800 (PST)
* Source doc: CS329E_GROUP8_README
* Tables are currently converted to HTML tables.
----->


**Name of project:** UT Apartment/ UT APT

**Group 8 team members:** Mingda Li, Ruiqi Liu, Junyu Yao

**Dependencies:** Xcode 14.1, Swift 5.7

**Special Instructions:**



* Use an iPhone 14 Pro Max Simulator
* Before running the app on an actual iPhone, set iPhone to developer mode
* One test account (or you can create your own):
    * Email: [test@gmail.com](mailto:test@gmail.com)
    * Password: 1234567
* Stable internet connection, profile picture takes some time to load
* For login game: Swipe left or right to adjust UT Tower, and swipe up to unlock when it is upward
* For collectionView page: can click (two fingers using touchpad) and hold and drag cells
* For reset password emails: Emails can usually be found under spam/trash folder
* For user profiles: After edit avatar, username, address, budget, need to click on save button to save any changes. The defaults of dark mode and big font are both off every time a user enters the app.
* For music sound: Click the button to play a random piano piece, and then click again to mute, click again to play, click again to mute.
* For apartment detail page: Click the picture of the apartment to jump in a new page that allows you to save pictures to the local album.

**Required feature checklist (We list what we finished)**



* Login/register path with Firebase
* “Settings” screen. The three behaviors we implemented are: dark mode, sound on/off, font change
* Non-default fonts and colors used

Two major elements used:



* Core Data
    * Our favorite list is implemented using core data
* User Profile path using camera and photo library
* Some SwiftUI
    * This is an extra part beyond the two requirements, we have done part of SwiftUI with code

Minor Elements used



* Two additional view types such as sliders, segmented controllers, etc. The two we implemented are switches, bars and bar buttons.
* One of the following (we have one extra):
    * Collection View
    * Table View
* Two of the following (we have one extra):
    * Alerts
    * User Defaults
    * Stack Views
* At least one of the following per team member (we have only 3 team members):
    * Gesture Recognition
    * Animation
    * Core Location / MapKit

**Work Distribution Table**


<table>
  <tr>
   <td>Required Feature
   </td>
   <td>Description
   </td>
   <td>Who / Percentage worked on
   </td>
  </tr>
  <tr>
   <td>Login/Register
   </td>
   <td>Using Firebase to allow users to create account and login
   </td>
   <td>Junyu (100%)
   </td>
  </tr>
  <tr>
   <td>UI Design
   </td>
   <td>Team shared equally in designing the wireframe for the app, and selecting colors and fonts
   </td>
   <td>Mingda (33%)
<p>
Ruiqi (33%)
<p>
Junyu(33%)
   </td>
  </tr>
  <tr>
   <td>Settings
   </td>
   <td>Allow user to change sound, dark mode, and font
   </td>
   <td>Mingda (100%)
   </td>
  </tr>
  <tr>
   <td>Profile Path
   </td>
   <td>Allow users to change profile, take/select photos as avatar.
   </td>
   <td>Junyu (50%)
<p>
Mingda (50%)
   </td>
  </tr>
  <tr>
   <td>Login Game
   </td>
   <td>Allow users to rotate the UTTower to unlock the app.
   </td>
   <td>Mingda (100%)
   </td>
  </tr>
  <tr>
   <td>Favorite Apartment List
   </td>
   <td>Allow users to add apartments to the favorite list (list is stored and shared using core data).
   </td>
   <td>Junyu (100%)
   </td>
  </tr>
  <tr>
   <td>Apartment List (CollectionView)
   </td>
   <td>Use Collection View to show most of the apartments at West Campus, users can hold and drag cells. 
   </td>
   <td>Ruiqi (100%)
   </td>
  </tr>
  <tr>
   <td>Detailed Introduction of Each Apartment
   </td>
   <td>Implement Image View to show the image. 
<p>
Include price range and distance from each apartment to GDC building (Use Core Location to show the precise distance). 
<p>
Include a map showing what's around each apartment (MapKit).
   </td>
   <td>Ruiqi (100%)
   </td>
  </tr>
  <tr>
   <td>Save Picture
   </td>
   <td>Allow users to save apartment pictures to local albums.
   </td>
   <td>Mingda (100%)
   </td>
  </tr>
  <tr>
   <td>Alerts
   </td>
   <td>Pop up alerts when add favorites, delete favorites, and send change email password email.
   </td>
   <td>Junyu (100%)
   </td>
  </tr>
</table>

