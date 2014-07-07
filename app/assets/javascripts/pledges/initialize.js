var ready;
ready = function() {

  requestedItemsController = new RequestedItemsController(new RequestedItemsList, new RequestedItemsView);
  requestedItemsController.init()

  pledgedItemsController = new PledgedItemsController(new PledgedItemsList, new PledgedItemsView);

  appController = new ApplicationController(requestedItemsController, pledgedItemsController);
  appController.listenForPledge();
  appController.listenForPledgesSubmit();

};

$(document).ready(ready);
$(document).on('page:load', ready);