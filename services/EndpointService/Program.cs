using AddContactService.Data;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddTransient< IServiceBus, ServiceBus>();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.MapPost("Add/Contact", async (IServiceBus serviceBus, string name, string lastname, string email, string phone) =>
{
    await serviceBus.SendMessageAsync(name, lastname, email, phone);
    return Results.Ok(new { Message = "Contact added successfully" });
})
.WithName("AddContact");

app.Run();