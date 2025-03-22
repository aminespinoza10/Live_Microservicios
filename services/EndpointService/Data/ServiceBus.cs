using Microsoft.Azure.ServiceBus;
using System.Text.Json;
using System.Text;

namespace AddContactService.Data
{
    public interface IServiceBus
    {
        Task SendMessageAsync(string name, string lastname, string mail, string phone);
    }

    public class ServiceBus: IServiceBus
    {
        private readonly IConfiguration _configuration;

        public ServiceBus(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task SendMessageAsync(string name, string lastname, string mail, string phone)
        {
            IQueueClient client = new QueueClient(_configuration["ServiceBus:AzureServiceBusConnectionString"], _configuration["ServiceBus:QueueName"]);
            var messageBody = ($"Name: {name}, Lastname: {lastname}, Email: {mail}, Phone: {phone}");

            var message = new Message(Encoding.UTF8.GetBytes(messageBody))
            {
                MessageId = Guid.NewGuid().ToString(),
                ContentType = "application/json"
            };

            await client.SendAsync(message);
        }
    }
}
