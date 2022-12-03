interface IPUSHCommInterface {
    function sendNotification(address channel, address recipient, bytes calldata _identity) external;
}